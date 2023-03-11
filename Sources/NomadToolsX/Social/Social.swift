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
    
    public init?(providerIndex: Int) {
        switch providerIndex {
        case 0: self = .apple
        case 1: self = .gamecenter
        case 2: self = .google
        case 3: self = .facebook
        case 4: self = .twitter
        case 5: self = .instagram
        case 6: self = .uber
        case 7: self = .lyft
        case 8: self = .wikipedia
        default: return nil
        }
    }
    
    public var providerIndex: Int? {
        switch self {
        case .apple: return 0
        case .gamecenter: return 1
        case .google: return 2
        case .facebook: return 3
        case .twitter: return 4
        case .instagram: return 5
        case .uber: return 6
        case .lyft: return 7
        case .wikipedia: return 8
        default: return nil
        }
    }
    
    public var firebaseAuthId: String? {
        switch self {
        case .google: return "google.com"
        case .facebook: return "facebook.com"
        case .apple: return "apple.com"
        default: return nil
        }
    }
    
    public var label: String {
        switch self {
        case .gamecenter: return "Game Center"
        default: return rawValue.capitalized
        }
    }
    
    public var icon: UIImage? {
        switch self {
        case .gamecenter,
             .google:
            return UIImage(named: self.rawValue + "_colored", in: .module, compatibleWith: nil)
            
        default:
            return UIImage(named: self.rawValue, in: .module, compatibleWith: nil)
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
