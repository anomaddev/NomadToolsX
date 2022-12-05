//
//  IconInput.swift
//  NomadTools
//
//  Created by Justin Ackermann on 5/29/22.
//

// Core iOS
import UIKit

// Utilities

import Cartography

open class IconInput: UITextField, Attributed {
    public var defaultAttributes: [Attribute] = [
        .font(.Medium, size: 16),
        .textColor(.onBackground),
        .backgroundColor(.background)
    ]
    
    private var _offset: NSLayoutConstraint!
    private var _offset2: NSLayoutConstraint!
    public lazy var icon: ImageView = ImageView([
        .alpha(0.4)
    ])
    
    public var padding: UIEdgeInsets!
    
    public init(with attributes: [Attribute]! = [],
                padding: UIEdgeInsets! = UIEdgeInsets(top: 0, left: 45, bottom: 0, right: 5)) {
        super.init(frame: .zero)
        self.padding = padding
        self.clearButtonMode = .whileEditing
        self.isUserInteractionEnabled = true
        self.setAttributes(defaultAttributes)
        
        self.addTarget(self, action: #selector(selected), for: .editingDidBegin)
        self.addTarget(self, action: #selector(deselected), for: .editingDidEnd)
        
        add(icon)
        constrain(icon)
        { icon in
            let superview = icon.superview!
            _offset2 = icon.left == superview.left + 12.5
            _offset = icon.top == superview.top + 12.5
            icon.centerY == superview.centerY
            icon.width == icon.height
        }
        
        self.setAttributes(attributes)
        layoutIfNeeded()
    }
    
    override open func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.clearButtonRect(forBounds: bounds)
        return rect.offsetBy(dx: -padding.right, dy: 0)
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    public func setAttributes(_ attributes: [Attribute]) {
        setView(attributes)
        for attribute in attributes {
            switch attribute {
            case .offset(let val):
                _offset.constant = val ?? 12.5
                _offset2.constant = val ?? 12.5
                
            case .placeholder(let place): placeholder = place
            case .text(let txt): text = txt
            case .textColor(let color): textColor = color
            case .textAlignment(let align): textAlignment = align
            case .font(let f, size: let s): font = f.getFont(size: s)
            case .keyboard(let type): keyboardType = type
            case .autocorrection(let auto): autocorrectionType = auto
            case .capitalization(let cap): autocapitalizationType = cap
            case .icon(let image, let color): icon.image = image.tint()
            case .padding(let top, let right, let bottom, let left):
                padding = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
            default: break
            }
        }
        
        layoutIfNeeded()
    }
    
    @objc func selected() {
        UIView.animate(withDuration: 0.25, animations: {
            self.icon.alpha = 1
            self.layoutIfNeeded()
        })
    }
    
    @objc func deselected() {
        UIView.animate(withDuration: 0.25, animations: {
            self.icon.alpha = 0.4
            self.layoutIfNeeded()
        })
    }
    
    required public init?(coder: NSCoder)
    { super.init(coder: coder) }
}
