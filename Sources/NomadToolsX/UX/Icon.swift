//
//  Icon.swift
//  
//
//  Created by Justin Ackermann on 3/16/23.
//

import UIKit

public protocol Asset {
    var image: UIImage? { get }
}

public enum Icon: String, CaseIterable, Asset {
    
    case bell
    
    case calendar
    case check
    case chevron
    case close
    case closeBold
    
    case editdots
    
    case flashOff
    case flashOn
    
    case home
    
    case imprt
    
    case leftArrow
    case list
    
    case menu
    case menu2
    
    case pause
    case pencil
    case play
    case plus
    
    case qrcode
    
    case refresh
    case rightArrow
    
    case save
    case search
    
    case trash
    
    case user
    
    case world
    
    public var image: UIImage? {
        return UIImage(
            named: rawValue,
            in: .module,
            compatibleWith: nil
        )
    }
}

extension UIImageView {
    public func tinted(icon: Icon, _ color: UIColor) {
        image = icon.image
        tintColor = color
    }
    
    public func tinted(asset: Asset, _ color: UIColor) {
        image = asset.image
        tintColor = color
    }
}
