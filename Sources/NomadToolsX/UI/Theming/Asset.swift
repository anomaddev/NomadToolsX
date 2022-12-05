//
//
//  Asset.swift
//  NomadTools
//
//  Created by Justin Ackermann on 5/27/21.
//

// Core iOS
import UIKit
import Foundation

public protocol NomadAsset {
    var raw: String { get }
}

//extension Nomad {
public enum IconAsset: String, NomadAsset {
   
    // Generic
    case backArrow
    case bell
    
    case calendar
    case chart
    case checkmark
    case chevron
    
    case dash
    case doubleChevron
    
    case edit
    
    case flashOff
    case flashOn
    case fullscreen
    
    case hashtag
    
    case landing
    case list
    case luggage
    
    case menu
    case menu2
    
    case passport
    case plane
    case plus
    
    case qrcode
    
    case refresh
    
    case search
    case settings
    
    case takeoff
    case time
    case trash
    
    case user
    
    case world
    
    // Arrows
    case upArrow
    case downArrow
    case leftArrow
    case rightArrow
    
    // Media
    case play
    case pause
    
    // Social & Sites
    case apple
    
    case facebook
    
    case google
    
    case lyft
    
    case uber
    
    case wikipedia
    
    public var raw: String
    { self.rawValue }
}

public enum Image {
    case asset(NomadAsset)
    case icon(IconAsset)
    case named(String)
    case empty
    
    public var image: UIImage? {
        switch self {
        case .asset(let asset):
            return UIImage(named: asset.raw)
            
        case .icon(let icon):
            return UIImage(
                named: icon.raw
            )
            
        case .named(let named):
            return UIImage(named: named)
            
        default: return nil
        }
    }
    
    public init(nomad asset: NomadAsset)
    { self = .asset(asset) }
    
    public init(asset: IconAsset)
    { self = .icon(asset) }
    
    public func tint(_ color: UIColor! = .onBackground) -> UIImage?
    { return image?.withTintColor(color, renderingMode: .alwaysTemplate) }
}
