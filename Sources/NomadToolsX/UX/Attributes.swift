//
//  Attributes.swift
//  NomadTools
//
//  Created by Justin Ackermann on 5/28/21.
//

import UIKit

public protocol Attributed {
    var defaultAttributes: [Attribute] { get }
}

public struct AnchoredConstraints {
    public var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
}

public enum Attribute {
    
    // MARK: REQUIRED
    
    /// Constraints
    case offset(CGFloat! = 12.5)
    
    /// UIView
    case tag(Int)
    case alpha(CGFloat)
    case interaction(Bool)
    case backgroundColor(UIColor)
    case borderColor(UIColor)
    case borderWidth(CGFloat)
    case cornerRadius(CGFloat! = 0)
    case corners(CACornerMask)
    case addShadow(color: UIColor! = .onBackground, opacity: Float! = 0.4, radius: CGFloat! = 2, offset: CGSize! = .square(2))
    
    /// Sizing
    case square(CGFloat)
    case setHeight(CGFloat)
    case setWidth(CGFloat)
    case setSize(CGSize)
    case setWidthHeight(CGFloat, CGFloat)
    case padding(surrounding: CGFloat)
    // MARK: END REQUIRED
    
    /// UILabel
    case text(String?)
    case attributed(NSAttributedString?)
    case textColor(UIColor)
    case textAlignment(NSTextAlignment)
    case minimumTextScale(CGFloat)
    case font(Font, size: CGFloat! = 14, alt: Bool! = false)
    case resize(Bool)
    case numberOfLines(Int)
    case padding(top: CGFloat, right: CGFloat, bottom: CGFloat, left: CGFloat)
    
    /// UIImageView
    case icon(Icon, UIColor? = Nomad.theme.onBackground, rotated: Float? = nil)
    case image(UIImage?)
    case asset(Asset, UIColor? = nil, rotated: Float? = nil)
    case contentMode(UIView.ContentMode)
    case tintColor(UIColor)
    
    /// UIStackView
    case alignment(UIStackView.Alignment)
    case distribution(UIStackView.Distribution)
    case axis(NSLayoutConstraint.Axis)
    case spacing(CGFloat)
    
    /// Icon Views
    case iconSize(CGSize)
    
    /// Buttons
    case selectedText(String?)
    case selectedColor(UIColor)
    case selectedBorder(UIColor)
    
    /// Inputs
    case placeholder(String?)
    case title(String?)
    case keyboard(UIKeyboardType)
    case autocorrection(UITextAutocorrectionType)
    case capitalization(UITextAutocapitalizationType)
    
    /// UIViewController
    case header(NSAttributedString)
    case controllerView([Attribute])
    case opaque(Bool)
    
    /// MANY
    case insets(UIEdgeInsets)
    case rotated(degrees: Float)
}
