//
//  AppTheme.swift
//  abseil
//
//  Created by Justin Ackermann on 5/29/21.
//

import Foundation
import UIKit
import UIColorHexSwift

open class AppTheme {
    
    public var fontFamily: FontFamily = .HelveticaNeue
    public var altFontFamily: FontFamily = .PTSans
    
    public var primary:    UIColor = UIColor("#00838f")
    public var light:      UIColor = UIColor("#4fb3bf")
    public var dark:       UIColor = UIColor("#005662")
    public var secondary:  UIColor = UIColor("#212121")
    public var secLight:   UIColor = UIColor("#212121")
    public var secDark:    UIColor = UIColor("#212121")
    public var error:      UIColor = UIColor("#d50000")
    public var success:    UIColor = UIColor("#1FAD51")
    public var surface:    UIColor = UIColor("#e0e0e0")
    public var darkSurface: UIColor = UIColor("#666666")
    public var background: UIColor = UIColor("#fafafa")
    public var warning:    UIColor = UIColor("#ECB000")
    
    public var onPrimary:      UIColor = UIColor("#fafafa")
    public var onSecondary:    UIColor = UIColor("#fafafa")
    public var onError:        UIColor = UIColor("#fafafa")
    public var onSuccess:      UIColor = UIColor("#fafafa")
    public var onSurface:      UIColor = UIColor("#212121")
    public var onDarkSurface:  UIColor = UIColor("#fafafa")
    public var onBackground:   UIColor = UIColor("#212121")
    public var onWarning:      UIColor = UIColor("#fafafa")
    
    public var palette: [String: UIColor] = [:]
    
    public init(_ colors: [Color]! = [],
                font: FontFamily! = .HelveticaNeue,
                altFont: FontFamily! = .PTSans) {
        fontFamily = font
        altFontFamily = altFont
        
        colors.forEach {
            switch $0 {
            case .onBackground(let c): onBackground = c
            case .background(let c): background = c
                
            case .onSurface(let c): onSurface = c
            case .surface(let c): surface = c
            case .onDarkSurface(let c): onDarkSurface = c
            case .darkSurface(let c): darkSurface = c
                
            case .onPrimary(let c): onPrimary = c
            case .primary(let c): primary = c
            case .primaryLight(let c): light = c
            case .primaryDark(let c): dark = c
                
            case .onSecondary(let c): onSecondary = c
            case .secondary(let c): secondary = c
            case .secondaryLight(let c): secLight = c
            case .secondaryDark(let c): secDark = c
                
            case .onSuccess(let c): onSuccess = c
            case .success(let c): success = c
                
            case .onError(let c): onError = c
            case .error(let c): error = c
                
            case .onWarning(let c): onWarning = c
            case .warning(let c): warning = c
            }
        }
    }
    
    public enum Color {
        case onBackground(UIColor)
        case background(UIColor)
        
        case onSurface(UIColor)
        case surface(UIColor)
        case onDarkSurface(UIColor)
        case darkSurface(UIColor)
        
        case onPrimary(UIColor)
        case primary(UIColor)
        case primaryLight(UIColor)
        case primaryDark(UIColor)
        
        case onSecondary(UIColor)
        case secondary(UIColor)
        case secondaryLight(UIColor)
        case secondaryDark(UIColor)
        
        case onSuccess(UIColor)
        case success(UIColor)
        
        case onError(UIColor)
        case error(UIColor)
        
        case onWarning(UIColor)
        case warning(UIColor)
    }
    
    public enum Key: String {
        case primary
        case light
        case dark
        case alternate
        case accent
        case tablet
        case desktop
        case iOS
        case macOS
        case warning
        case error
        case success
    }
}



