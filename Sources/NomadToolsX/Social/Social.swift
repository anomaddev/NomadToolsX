//
//  Social.swift
//  
//
//  Created by Justin Ackermann on 12/5/22.
//

import UIKit

public enum Social: String, Codable {
    
    case apple
    case gamecenter
    case google
    
    case facebook
    case twitter
    case instagram
    
    case uber
    case lyft
    
    case wikipedia
    
    public init?(providerId: String) {
        switch providerId {
        case "google.com": self = .google
        case "facebook.com": self = .facebook
        case "apple.com": self = .apple
        default: return nil
        }
    }
    
    public var label: String {
        switch self {
        case .gamecenter: return "Game Center"
        default: return rawValue.capitalized
        }
    }
    
    public var color: UIColor {
        switch self {
        case .facebook: return UIColor("#3b5998")
        case .gamecenter: return .white
        case .apple: return .black
        case .google: return UIColor("#f7f7f7")
        default: return .black
        }
    }
    
    public var onColor: UIColor {
        switch self {
        case .facebook: return UIColor("#f7f7f7")
        case .gamecenter: return .black
        case .apple: return .white
        case .google: return .black
        default: return .black
        }
    }
}
