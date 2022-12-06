//
//  Social.swift
//  
//
//  Created by Justin Ackermann on 12/5/22.
//

import UIKit

public enum Social: String {
    
    case apple
    case google
    
    case facebook
    case twitter
    case instagram
    
    case uber
    case lyft
    
    case wikipedia
    
    public var color: UIColor {
        switch self {
        case .facebook: return UIColor("#3b5998")
        case .apple: return .black
        case .google: return .background
        default: return .black
        }
    }
    
    public var onColor: UIColor {
        switch self {
        case .facebook: return UIColor("#f7f7f7")
        case .apple: return .white
        case .google: return .onBackground
        default: return .black
        }
    }
}
