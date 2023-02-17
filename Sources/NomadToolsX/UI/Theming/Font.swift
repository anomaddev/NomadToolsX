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
    case Raleway
    
}
//    public var value: [String] {
//        switch self {
//        case .PTSans:
//            return [
//                "PTSans-Regular",
//                "PTSans-Italic",
//                "PTSans-Bold",
//                "PTSans-BoldItalic"
//            ]
//
//        case .Raleway:
//            return [
//                "Raleway-Regular",
//                "Raleway-Bold",
//                "Raleway-Medium",
//                "Raleway-Thin",
//                "Raleway-Light"
//            ]
//
//        default:
//            /// register system fonts
//            return [
//                "HelveticaNeue",
//                "HelveticaNeue-Thin",
//                "HelveticaNeue-Light",
//                "HelveticaNeue-Medium",
//                "HelveticaNeue-Bold"
//            ]
//        }

public enum Font: String, CaseIterable {
    
    public static var Key: NSAttributedString.Key = .font
    public static var Strikethrough: NSAttributedString.Key = .strikethroughStyle
    
//    case Default
    case Regular
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
    case Italic
    case SemiBold
    case SemiBoldItalic
    case ThinItalic
    case MediumItalic
    case ExtraBoldItalic
    case ExtraBold
    
    public func getFont(size: CGFloat? = 14,
                        alternative: Bool! = false) -> UIFont
    {
        guard let size = size else { return UIFont(name: "HelveticaNeue", size: 14)! }
        let fontFamily = alternative ? Nomad.theme.altFontFamily : Nomad.theme.fontFamily
        let thefont = "\(fontFamily.rawValue)-\(self.rawValue)"
        guard let font = UIFont(name: thefont, size: size)
        else {
            let fallback = "\(fontFamily.rawValue)-\(Font.Regular.rawValue)"
            guard let font = UIFont(name: fallback.rawValue, size: size)
            else {
                print("The Font: \(thefont)")
                print("The Fallback: \(fallback)")
                fatalError("You are attempting to get an invalid font and the fallback failed")
            } // THROW:
            return font
        }
        return font
    }
//        switch fontFamily {
//        case .HelveticaNeue:
//            switch self {
//            case .Thin:     return UIFont(name: "HelveticaNeue-Thin", size: size)!
//            case .Light:    return UIFont(name: "HelveticaNeue-Light", size: size)!
//            case .Medium:   return UIFont(name: "HelveticaNeue-Medium", size: size)!
//            case .Bold:     return UIFont(name: "HelveticaNeue-Bold", size: size)!
//
//            default:        return UIFont(name: "HelveticaNeue", size: size)!
//            }
//
//        case .PTSans:
//            switch self {
//            case .Italic:   return UIFont(name: "PTSans-Italic", size: size)!
//            case .Bold:     return UIFont(name: "PTSans-Bold", size: size)!
//            case .BoldItalic: return UIFont(name: "PTSans-BoldItalic", size: size)!
//
//            default:        return UIFont(name: "PTSans-Regular", size: size)!
//            }
//
//        case .Raleway:
//            switch self {
//            case .Bold:     return UIFont(name: "Raleway-Bold", size: size)!
//            case .BoldItalic: return UIFont(name: "Raleway-BoldItalic", size)!
//            default:        return UIFont(name: "Raleway-Regular", size: size)!
//            }
//        }
//    }
    
    public static func loadFonts(active: [FontFamily]! = FontFamily.allCases) {
        let fontNames = active
            .filter {
                $0 != .HelveticaNeue
                /// accounting for system fonts not in Nomad bundle
            }
            .map { name in Font.allCases.map { "\(name.rawValue)-\($0.rawValue)" }}
            .reduce([], +)
        for fontName in fontNames
        { try? loadFont(withName: fontName) }
    }
    
    private static func loadFont(withName fontName: String) throws {
        guard let asset = NSDataAsset(name: "Fonts/\(fontName)", bundle: Bundle.module),
              let provider = CGDataProvider(data: asset.data as NSData),
              let font = CGFont(provider),
              CTFontManagerRegisterGraphicsFont(font, nil) else {
            print(fontName)
            throw NSError()
        }
    }
}
