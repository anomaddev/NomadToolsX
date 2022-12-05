//
//  Font.swift
//  NomadTools
//
//  Created by Justin Ackermann on 5/28/21.
//

import UIKit

public enum FontFamily: String, CaseIterable {
    
    case HelveticaNeue
    case PTSans
    
    public var value: [String] {
        switch self {
        case .PTSans:
            return [
                "PTSans-Regular",
                "PTSans-Italic",
                "PTSans-Bold",
                "PTSans-BoldItalic"
            ]
            
        default:
            /// register system fonts
            return [
                "HelveticaNeue",
                "HelveticaNeue-Thin",
                "HelveticaNeue-Light",
                "HelveticaNeue-Medium",
                "HelveticaNeue-Bold"
            ]
        }
    }
}

public enum Font {
    
    public static var Key: NSAttributedString.Key = .font
    public static var Strikethrough: NSAttributedString.Key = .strikethroughStyle
    
    case Default
    case Thin
    case Light
    case Medium
    case Bold
    
    case Black
    case BlackItalic
    case BoldItalic
    case ExtraLight
    case ExtraLightItalic
    case LightItalic
    case Regular
    case Italic
    case SemiBold
    case SemiBoldItalic
    
    public func getFont(size: CGFloat? = 14,
                        alternative: Bool! = false) -> UIFont
    {
        guard let size = size else { return UIFont(name: "HelveticaNeue", size: 14)! }
        let fontFamily = alternative ? Nomad.theme.altFontFamily : Nomad.theme.fontFamily
        
        switch fontFamily {
        case .HelveticaNeue:
            switch self {
            case .Default:  return UIFont(name: "HelveticaNeue", size: size)!
            case .Thin:     return UIFont(name: "HelveticaNeue-Thin", size: size)!
            case .Light:    return UIFont(name: "HelveticaNeue-Light", size: size)!
            case .Medium:   return UIFont(name: "HelveticaNeue-Medium", size: size)!
            case .Bold:     return UIFont(name: "HelveticaNeue-Bold", size: size)!
                
            default:        return UIFont(name: "HelveticaNeue", size: size)!
            }
            
        case .PTSans:
            switch self {
            case .Default:  return UIFont(name: "PTSans-Regular", size: size)!
            case .Italic:   return UIFont(name: "PTSans-Italic", size: size)!
            case .Bold:     return UIFont(name: "PTSans-Bold", size: size)!
            case .BoldItalic: return UIFont(name: "PTSans-BoldItalic", size: size)!
                
            default:        return UIFont(name: "PTSans-Regular", size: size)!
            }
        }
    }
    
    public static var loadFonts: () -> Void = {
        let fontNames = FontFamily
            .allCases
            .filter {
                $0 != .HelveticaNeue
                /// accounting for system fonts not in Nomad bundle
            }
            .map { $0.value }
            .reduce([], +)
        for fontName in fontNames
        { loadFont(withName: fontName) }
        return {}
    }()
    
    private static func loadFont(withName fontName: String) {
        guard
            let bundleURL = Bundle(for: Nomad.self).url(forResource: "NomadTools", withExtension: "bundle"),
            let bundle = Bundle(url: bundleURL),
            let fontURL = bundle.url(forResource: fontName, withExtension: "ttf"),
            let fontData = try? Data(contentsOf: fontURL) as CFData,
            let provider = CGDataProvider(data: fontData),
            let font = CGFont(provider) else {
                return
            }
        CTFontManagerRegisterGraphicsFont(font, nil)
    }
}
