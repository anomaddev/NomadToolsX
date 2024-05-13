//
//  Input.swift
//  NomadTools
//
//  Created by Justin Ackermann on 3/21/22.
//

// Core iOS
import UIKit

// Utilities
import NomadUI
import Cartography

open class Input: UITextField, Attributed {
    public var defaultAttributes: [Attribute] = [
        .font(.Regular, size: 16),
        .textColor(.background.onColor),
        .cornerRadius(5),
        .backgroundColor(.surface)
    ]
    
    public var padding: UIEdgeInsets! = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    private var timer: Timer?
    public var delayValue: Double = 1.0
    public var delayedAction: (() -> Void)?
    public var delayedEnabled: Bool = false {
        didSet {
            if delayedEnabled { self.addTarget(self, action: #selector(changedValue), for: .editingChanged) }
            else { self.removeTarget(self, action: #selector(changedValue), for: .editingChanged) }
        }
    }
    
    public init(_ attributes: [Attribute]! = []) {
        super.init(frame: .zero)
        setAttributes(defaultAttributes)
        setAttributes(attributes)
    }
    
    public init(style: Style, with attributes: [Attribute]! = []) {
        super.init(frame: .zero)
        
        switch style {
        case .Rounded:
            self.setAttributes(defaultAttributes)
            self.addShadow()
            
        case .Flat:
            self.setAttributes([
                .font(.Regular, size: 16),
                .textColor(.background.onColor),
                .backgroundColor(.surface)
            ])
        }
        
        self.setAttributes(attributes)
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
            case .placeholder(let place): placeholder = place
            case .text(let txt): text = txt
            case .textColor(let color): textColor = color
            case .textAlignment(let align): textAlignment = align
            case .font(let f, let s, let alt): font = f.getFont(size: s, alternative: alt)
            case .keyboard(let type): keyboardType = type
            case .autocorrection(let auto): autocorrectionType = auto
            case .capitalization(let cap): autocapitalizationType = cap
            case .padding(let top, let right, let bottom, let left):
                padding = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
            default: break
            }
        }
        
        layoutIfNeeded()
    }
    
    @objc public func runAction(_ sender: Timer!)
    { delayedAction?() }
    
    @objc public func changedValue(_ sender: UITextField) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: delayValue, target: self, selector: #selector(runAction), userInfo: nil, repeats: false)
    }
    
    public enum Style {
        case Rounded
        case Flat
    }
    
    required public init?(coder: NSCoder)
    { super.init(coder: coder) }
}

open class TitledInput: NomadView {
    
    public var text: String? {
        set { input.text = newValue }
        get { input.text }
    }
    
    public lazy var input: Input = Input([
        .padding(top: 0, right: 15, bottom: 0, left: 15),
        .addShadow(opacity: 0.25, radius: 2, offset: .square(1)),
        .backgroundColor(.background.color)
    ])
    
    private var _centered: NSLayoutConstraint!
    public lazy var _title: Header = Header(title, style: .H6, height: 15)
    
    public var title: String? {
        didSet { _title.text = title }
    }
    
    public init(style: Style,_ attributes: [Attribute]! = []) {
        super.init(frame: .zero, attributes)
        add(_title, input)
        constrain(_title, input)
        { title, input in
            let superview = title.superview!
            
            title.top ~== superview.top
            _centered = title.left ~== superview.left + 15
            title.centerX ~== superview.centerX
            
            input.top ~== title.bottom + 7.5
            input.left ~== superview.left
            input.right ~== superview.right
            input.bottom ~== superview.bottom
        }
        
        self.setAttributes(attributes)
        input.addShadow()
        
        switch style {
        case .Flat:
            input.setAttributes([
                .font(.Regular, size: 16),
                .textColor(.background.onColor),
                .backgroundColor(.background.color),
                .cornerRadius(0),
                .padding(top: 0, right: 20, bottom: 0, left: 20),
            ])
            
        default: break
        }
        
        backgroundColor = .clear
        layoutIfNeeded()
    }
    
    public func setAttributes(_ attributes: [Attribute]) {
        setView(attributes)
        input.setAttributes(attributes)
        for attribute in attributes {
            switch attribute {
            case .title(let str): title = str
            case .textAlignment(let align):
                _title.textAlignment = align
                if align == .center { _centered.constant = 0 }
            default: break
            }
        }
        layoutIfNeeded()
    }
    
    public enum Style {
        case Rounded
        case Flat
    }
    
    required public init?(coder: NSCoder)
    { super.init(coder: coder) }
}
