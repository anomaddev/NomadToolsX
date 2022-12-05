//
//  RandomUser.swift
//  NomadTools
//
//  Created by Justin Ackermann on 12/27/21.
//

import Foundation
//import Alamofire

open class RandomUser: Codable {
    
    public var gender: String?
    public var name: Name?
    public var location: Location?
    public var email: String?
    public var login: Login
    
}

public struct Name: Codable {
    public var title: String?
    public var first: String?
    public var last: String?
}

public struct Location: Codable {
    public var street: Street?
    public var city: String?
    public var country: String?
    public var postcode: Int?
    public var coordinates: Coordinate?
    public var timezone: TimeZ?
}

public struct Street: Codable {
    public var number: Int?
    public var name: String?
}

public struct Coordinate: Codable {
    public var latitude: String?
    public var longitude: String?
}

public struct TimeZ: Codable {
    public var offset: String?
    public var description: String?
}

public struct Login: Codable {
    public var uuid: String?
    public var username: String
    public var password: String?
    public var salt: String?
    public var md5: String?
    public var sha1: String?
    public var sha256: String?
}

// TODO: Finish below struct

//"gender": "male",
//      "name": {
//        "title": "Mr",
//        "first": "Noah",
//        "last": "Zhang"
//      },
//      "location": {
//        "street": {
//          "number": 7260,
//          "name": "Riccarton Road"
//        },
//        "city": "Gisborne",
//        "state": "Taranaki",
//        "country": "New Zealand",
//        "postcode": 97302,
//        "coordinates": {
//          "latitude": "65.9630",
//          "longitude": "-104.1001"
//        },
//        "timezone": {
//          "offset": "+11:00",
//          "description": "Magadan, Solomon Islands, New Caledonia"
//        }
//      },
//      "email": "noah.zhang@example.com",
//      "login": {
//        "uuid": "cffbc2bf-f713-4548-8f17-7ca7896e9c71",
//        "username": "beautifulladybug518",
//        "password": "wyoming",
//        "salt": "0DfltrGI",
//        "md5": "8ea9c082b0b99448f935e3e51d95d738",
//        "sha1": "494c6463eb920c2fff7455ae7b2f26fd182383a5",
//        "sha256": "b0fe9a57c10d0dca628bb537bb06936e47db6d1b4311a3267d44aea61841c4ca"
//      },
//      "dob": {
//        "date": "1985-09-26T16:44:53.119Z",
//        "age": 36
//      },
//      "registered": {
//        "date": "2013-08-30T02:31:40.433Z",
//        "age": 8
//      },
//      "phone": "(554)-967-4100",
//      "cell": "(565)-589-4185",
//      "id": {
//        "name": "",
//        "value": null
//      },
//      "picture": {
//        "large": "https://randomuser.me/api/portraits/men/49.jpg",
//        "medium": "https://randomuser.me/api/portraits/med/men/49.jpg",
//        "thumbnail": "https://randomuser.me/api/portraits/thumb/men/49.jpg"
//      },
//      "nat": "NZ"
