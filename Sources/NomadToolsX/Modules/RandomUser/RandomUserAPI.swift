//
//  RandomUserAPI.swift
//  NomadTools
//
//  Created by Justin Ackermann on 12/27/21.
//

import Foundation
//import FirebaseCore
//import PromiseKit
//import Alamofire

public class RandomUserAPI {
    
//    public static func fetch(users: Int! = 1) -> Promise<[RandomUser]> {
//        let urlString: String = "https://randomuser.me/api/?format=json"
//        return Promise { done in
//            do {
//                guard let url = URL(string: urlString) else { throw NSError() } // THROW:
//                print(url.absoluteString)
//                self.request(url)
//                    .done { done.fulfill($0.results) }
//                    .catch { done.reject($0) }
//            } catch { done.reject(error) }
//        }
//    }
//
//    private static func request(_ url: URL) -> Promise<RandomUserResult> {
//        return Promise { done in
//            let decoder: JSONDecoder = {
//                let decoder = JSONDecoder()
//                return decoder
//            }()
//
//            AF.request(url)
//                .validate()
//                .responseDecodable(of: RandomUserResult.self, decoder: decoder)
//            { response in
//                switch response.result {
//                case .success(let data): done.fulfill(data)
//                case .failure(let err):
//                    do {
//                        guard let data = response.data else { throw err }
//                        let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
//                        print(json)
//                        print()
//
//                        /// try again
//                        request(url)
//                            .done { done.fulfill($0) }
//                            .catch { done.reject($0) }
//                    } catch { print(error) }
//                }
//            }
//        }
//    }
}

public struct RandomUserResult: Codable {
    var results: [RandomUser]
    var info: RandomUserResultInfo?
}

public struct RandomUserResultInfo: Codable {
    var seed: String?
    var results: Int?
    var page: Int?
    var version: String?
}
