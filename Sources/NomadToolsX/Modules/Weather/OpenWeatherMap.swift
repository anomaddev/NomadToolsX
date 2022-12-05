//
//  OpenWeatherMap.swift
//  NomadTools_Example
//
//  Created by Justin Ackermann on 5/27/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

//import Foundation
//import CoreLocation
//
//import PromiseKit
//import FirebaseFirestore
//import CodableFirebase
//import Alamofire
//import Kingfisher
//import ZippyJSON
//
//public class Weather: NSObject {
//
//    // DEV: Implement Units
//
//    fileprivate var apiKey: String?
//    fileprivate var base: String = "https://api.openweathermap.org/data/2.5/weather?lat={latCoord}&lon={lonCoord}&appid={apiKey}&units=imperial"
//
//    static let iconBase: String = "http://openweathermap.org/img/wn/{icon}@2x.png"
//    public static var get: Weather = Weather()
//
//    private override init()
//    { super.init() }
//
//    // MARK: URL Functions
//    public func set(apiKey key: String) { apiKey = key }
//    public func getweather(for coord: CLLocationCoordinate2D) -> Promise<WeatherResult> {
//        return Promise { done in
//            guard let key = apiKey else { throw NSError() } // THROW:
//            let lat = coord.latitude
//            let lon = coord.longitude
//
//            let path = self.base
//                .replacingOccurrences(of: "{latCoord}", with: "\(lat)")
//                .replacingOccurrences(of: "{lonCoord}", with: "\(lon)")
//                .replacingOccurrences(of: "{apiKey}", with: "\(key)")
//
//            guard let url = URL(string: path) else { return } // THROW:
//            print(url.absoluteString)
//            self.request(url).done {
//                var w = $0
//                w.updated = Timestamp()
//                done.fulfill(w)
//            }.catch { done.reject($0) }
//        }
//    }
//
//    public func request(_ url: URL) -> Promise<WeatherResult> {
//        return Promise { done in
//            let decoder: JSONDecoder = {
//                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
//                return decoder
//            }()
//
//            AF.request(url)
//                .validate()
//                .responseDecodable(of: WeatherResult.self, decoder: decoder)
//            { response in
//                switch response.result {
//                case .success(let data):
//                    done.fulfill(data)
//
//                case .failure(let error):
//                    error.whatisthis()
//                    done.reject(error)
//                }
//            }
//        }
//    }
//}
//
//public struct WeatherResult: Codable {
//    public var updated: Timestamp?
//    public var coord: Coord?
//
//    public var weather: [Quick]? = []
//    public var base: String?
//    public var main: WeatherData?
//    public var visibility: Int?
//    public var wind: Wind?
//    public var rain: [String: Double]?
//    public var snow: [String: Double]?
//    public var clouds: [String: Int]?
//    public var dt: Int?
//    public var timezone: Int?
//    public var id: Int?
//    public var name: String?
//    public var cod: Int?
//
//    public func icon() -> Promise<UIImage> {
//        return Promise { done in
//            guard let weather = weather?.first else { return } // THROW:
//            let path = Weather.iconBase.replacingOccurrences(of: "{icon}", with: "\(weather.icon)")
//            guard let url = URL(string: path) else { return } // THROW:
//            let resource = ImageResource(downloadURL: url)
//
//            KingfisherManager.shared.retrieveImage(with: resource,
//                                                   options: nil,
//                                                   progressBlock: nil)
//            { result in
//                switch result {
//                case .success(let value): done.fulfill(value.image)
//                case .failure(let error): done.reject(error)
//                }
//            }
//        }
//    }
//}
//
//public struct Coord: Codable {
//    public let lon: Float
//    public let lat: Float
//}
//
//public struct Quick: Codable {
//    public let id: Int
//    public let main: String
//    public let description: String
//    public let icon: String
//}
//
//public struct WeatherData: Codable {
//    public let temp: Float
//    public let feelsLike: Float
//    public let tempMin: Float
//    public let tempMax: Float
//    public let pressure: Int
//    public let humidity: Int
//}
//
//public struct Wind: Codable {
//    public let speed: Float
//    public let deg: Int
//}
//
//public struct System: Codable {
//    public let type: Int
//    public let id: Int
//    public let country: String
//    public let sunrise: Int
//    public let sunset: Int
//}
//
//public struct Rain: Codable {
//    public let _1h: String
//    public let _3h: String
//}
//
//public extension Data {
//    func weather() throws -> WeatherResult {
//        do {
//            let decoder = ZippyJSONDecoder()
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
//            return try decoder.decode(WeatherResult.self, from: self)
//        }
//        catch let DecodingError.dataCorrupted(context) {
//            print(context)
//            throw DecodingError.dataCorrupted(context)
//        } catch let DecodingError.keyNotFound(key, context) {
//            print("Key '\(key)' not found:", context.debugDescription)
//            print("codingPath:", context.codingPath)
//            throw DecodingError.keyNotFound(key, context)
//        } catch let DecodingError.valueNotFound(value, context) {
//            print("Value '\(value)' not found:", context.debugDescription)
//            print("codingPath:", context.codingPath)
//            throw DecodingError.valueNotFound(value, context)
//        } catch let DecodingError.typeMismatch(type, context)  {
//            print("Type '\(type)' mismatch:", context.debugDescription)
//            print("codingPath:", context.codingPath)
//            throw DecodingError.typeMismatch(type, context)
//        } catch { throw error }
//    }
//}
