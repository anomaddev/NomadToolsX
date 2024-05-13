//
//  UIView.swift
//  NomadTools
//
//  Created by Justin Ackermann on 3/20/22.
//

import UIKit

// Utilities
import NomadUI
import Cartography

open class NomadView: UIView, Attributed {
    public var defaultAttributes: [Attribute] = [
        .backgroundColor(.background.color),
        .borderWidth(0),
        .borderColor(.clear),
        .interaction(true)
    ]
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setView(defaultAttributes)
    }
    
    public init(frame: CGRect! = .zero, _ attributes: [Attribute]) {
        super.init(frame: frame)
        setView(defaultAttributes)
        setView(attributes)
    }
    
    required public init?(coder: NSCoder)
    { super.init(coder: coder) }
}

open class BlankView: NomadView {
    public init(_ attributes: [Attribute]! = []) {
        super.init(frame: .zero)
        setView(attributes)
    }
    
    public init(_ color: UIColor) {
        super.init(frame: .zero)
        backgroundColor = color
    }
    
    required public init?(coder: NSCoder)
    { super.init(coder: coder) }
}

open class Separator: UIView {
    
    lazy var line: BlankView = BlankView([
        .backgroundColor(.secondary.color),
        .cornerRadius(1)
    ])
    
    var padding: UIEdgeInsets = .init(top: 0, left: 30, bottom: 0, right: 30)
    { didSet {
        line.removeConstraints(line.constraints)
        constrain(line)
        { line in
            let superview = line.superview!
            line.left ~== superview.left + padding.left
            line.top ~== superview.top + padding.top
            line.right ~== superview.right - padding.right
            line.bottom ~== superview.bottom - padding.bottom
        }
        layoutIfNeeded()
    }}
     
    public init(padding: UIEdgeInsets! = .init(top: 0, left: 30, bottom: 0, right: 30),
                alpha: CGFloat! = 0.25,
                vertical: Bool! = false) {
        super.init(frame: .zero)
        line.alpha = alpha
        backgroundColor = .background.color
        add(line)
        constrain(line)
        { line in
            let superview = line.superview!
            line.left ~== superview.left + padding.left
            line.top ~== superview.top + padding.top
            line.right ~== superview.right - padding.right
            line.bottom ~== superview.bottom - padding.bottom
            
            if vertical { line.width ~== 2 }
            else { line.height ~== 2 }
        }
        
        layoutIfNeeded()
    }
    
    public required init?(coder: NSCoder)
    { super.init(coder: coder) }
}

open class Spacer: UIView {
    public init(w: CGFloat? = nil, h: CGFloat? = nil) {
        super.init(frame: .zero)
        if let w = w { constrainWidth(w) }
        if let h = h { constrainHeight(h) }
        layoutIfNeeded()
    }
    
    required public init?(coder: NSCoder)
    { super.init(coder: coder) }
}

// MARK: Extensions
extension UIView {
    public func setView(_ attributes: [Attribute]) {
        for attribute in attributes {
            switch attribute {
            case .tag(let t): tag = t
            case .alpha(let opacity): alpha = opacity
            case .backgroundColor(let color): backgroundColor = color
            case .interaction(let enabled): isUserInteractionEnabled = enabled
            case .borderColor(let color): layer.borderColor = color.cgColor
            case .borderWidth(let width): layer.borderWidth = width
            case .corners(let corners): layer.maskedCorners = corners
            case .cornerRadius(let radius):
                layer.cornerRadius = radius!
                layer.masksToBounds = true
                
            case .square(let size):
                constrainWidth(size)
                constrainHeight(size)
                
            case .setHeight(let height): constrainHeight(height)
            case .setWidth(let width): constrainWidth(width)
            case .setWidthHeight(let width, let height):
                constrainHeight(height)
                constrainWidth(width)
                
            case .setSize(let size):
                constrainHeight(size.height)
                constrainWidth(size.width)
                
            case .addShadow(let color, let opacity, let radius, let offset):
                addShadow(offset: offset, color: color, radius: radius, opacity: opacity)
                
            default: break
            }
        }
        
        layoutIfNeeded()
    }
}
