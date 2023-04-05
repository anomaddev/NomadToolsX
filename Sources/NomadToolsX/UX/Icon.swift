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
    case chevron
    
    case flashOff
    case flashOn
    
    case imprt
    
    case leftArrow
    case list
    
    case menu
    case menu2
    
    case plus
    
    case qrcode
    
    case refresh
    case rightArrow
    
    case search
    
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
