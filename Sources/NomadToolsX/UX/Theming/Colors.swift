//
//  Colors.swift
//  NomadTools
//
//  Created by Justin Ackermann on 7/5/21.
//

import UIKit

public extension UIColor {
    
    static var Foreground: NSAttributedString.Key = .foregroundColor
    static var Background: NSAttributedString.Key = .backgroundColor
    
    static var primary: UIColor     { Nomad.theme.primary }
    static var onPrimary: UIColor   { Nomad.theme.onPrimary }
    static var light: UIColor       { Nomad.theme.light }
    static var dark: UIColor        { Nomad.theme.dark }
    
    static var secondary: UIColor   { Nomad.theme.secondary }
    static var onSecondary: UIColor { Nomad.theme.onSecondary }
    static var secondaryLight: UIColor { Nomad.theme.secLight }
    static var secondaryDark: UIColor { Nomad.theme.secDark }
    
    static var error: UIColor       { Nomad.theme.error }
    static var onError: UIColor     { Nomad.theme.onError }
    
    static var success: UIColor     { Nomad.theme.success }
    static var onSuccess: UIColor   { Nomad.theme.onSuccess }
    
    static var surface: UIColor     { Nomad.theme.surface }
    static var onSurface: UIColor   { Nomad.theme.onSurface }
    static var darkSurface: UIColor { Nomad.theme.darkSurface }
    static var onDarkSurface: UIColor { Nomad.theme.onDarkSurface }
    
    static var warning: UIColor     { Nomad.theme.warning }
    static var onWarning: UIColor   { Nomad.theme.onWarning }
    
    static var background: UIColor { Nomad.theme.background }
    static var onBackground: UIColor { Nomad.theme.onBackground }
    
    static let dimmedLightBackground = UIColor(white: 100.0/255.0, alpha: 0.3)
    static let dimmedDarkBackground = UIColor(white: 50.0/255.0, alpha: 0.3)
    static let dimmedDarkestBackground = UIColor(white: 0, alpha: 0.5)
}

public extension CGColor {
    
    // Nomadic Theme
    static var primary: CGColor     { UIColor.primary.cgColor }
    static var onPrimary: CGColor   { UIColor.onPrimary.cgColor }
    
    static var light: CGColor       { UIColor.light.cgColor }
    static var dark: CGColor        { UIColor.dark.cgColor }
    
    static var secondary: CGColor   { UIColor.secondary.cgColor }
    static var onSecondary: CGColor { UIColor.onSecondary.cgColor }
    
    static var error: CGColor       { UIColor.error.cgColor }
    static var onError: CGColor     { UIColor.onError.cgColor }
    
    static var success: CGColor     { UIColor.success.cgColor }
    static var onSuccess: CGColor   { UIColor.onSuccess.cgColor }
    
    static var surface: CGColor     { UIColor.surface.cgColor }
    static var onSurface: CGColor   { UIColor.onSurface.cgColor }
    static var darkSurface: CGColor { UIColor.darkSurface.cgColor }
    static var onDarkSurface: CGColor { UIColor.onDarkSurface.cgColor }
    
    static var warning: CGColor     { UIColor.warning.cgColor }
    static var onWarning: CGColor   { UIColor.onWarning.cgColor }
    
    static var background: CGColor { UIColor.background.cgColor }
    static var onBackground: CGColor { UIColor.onBackground.cgColor }
    
    // UIColors
    static var black: CGColor
    { return UIColor.black.cgColor }
    
    static var white: CGColor
    { return UIColor.white.cgColor }
}

