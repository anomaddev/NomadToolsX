//
//  RoundView.swift
//  NomadTools
//
//  Created by Justin Ackermann on 5/28/21.
//

import UIKit

import Cartography

open class RoundView: NomadView {
    open var shadowLayer: CAShapeLayer!
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        contentMode = .scaleAspectFill
        layer.cornerRadius = layer.bounds.height / 2.0
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 25).cgPath
            shadowLayer.fillColor = backgroundColor?.cgColor

            shadowLayer.shadowColor = UIColor.darkGray.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            shadowLayer.shadowRadius = 2

            layer.insertSublayer(shadowLayer, at: 0)
            //layer.insertSublayer(shadowLayer, below: nil) // also works
        }
    }
    
    public init(_ attributes: [Attribute]) {
        super.init(frame: .zero)
        setView(attributes)
        layoutIfNeeded()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

open class RoundImageView: UIImageView, Attributed {
    public var defaultAttributes: [Attribute] = [
        .backgroundColor(.clear),
        .borderWidth(0),
        .borderColor(.clear)
    ]
    
    public init(_ attributes: [Attribute]) {
        super.init(frame: .zero)
        setAtributes(attributes)
    }
    
    public func setAtributes(_ attributes: [Attribute]) {
        setView(attributes)
        for attribute in attributes {
            switch attribute {
            case .image(let img): image = img
            case .icon(let asset, let color): image = asset.tint()
            default: break
            }
        }
        layoutIfNeeded()
    }
    
    required public init?(coder: NSCoder)
    { super.init(coder: coder) }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        contentMode = .scaleAspectFill
        layer.masksToBounds = false
        clipsToBounds = true
        layer.cornerRadius = layer.bounds.height / 2.0
    }
}

open class RoundIconView: RoundView {
    
    lazy public var iconView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    public var iconHeight: NSLayoutConstraint!
    public var iconWidth: NSLayoutConstraint!
    
    private var base: [Attribute]!
    private var selected: [Attribute]?
    
    public var isSelected: Bool = false {
        didSet { animateSelect(isSelected) }
    }
    
    public init(_ attributes: [Attribute],
                selected sattributes: [Attribute]? = nil) {
        super.init(attributes)
        base = attributes
        selected = sattributes
        
        let iconSize: CGSize = .square(15)
        add(iconView)
        constrain(iconView)
        { icon in
            let superview = icon.superview!
            
            iconHeight = icon.height ~== iconSize.height
            iconWidth = icon.width ~== iconSize.width
            icon.center ~== superview.center
            
            superview.width ~== superview.height
        }
        
        layoutIfNeeded()
        set(attributes)
    }
    
    public func set(attribute: Attribute, replace: Bool! = false) {
        if replace { base.append(attribute) }
        set([attribute])
    }
    
    func set(_ attributes: [Attribute]) {
        for attribute in attributes {
            switch attribute {
            case .iconSize(let size):
                iconHeight.constant = size.height
                iconWidth.constant = size.width
                
            case .icon(let img, let color):
                iconView.image = img.tint()
                
            default: break
            }
        }
    }
    
    private func animateSelect(_ selected: Bool) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.25, animations: {
                self.alpha = 0
            }) { _ in
                if selected { self.set(self.selected ?? self.base) }
                else { self.set(self.base) }
                
                UIView.animate(withDuration: 0.25, animations: {
                    self.alpha = 1
                })
            }
        }
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
    
public class FacebookIconView: RoundIconView {
    public override init(_ attributes: [Attribute],
                  selected sattributes: [Attribute]? = nil) {
        super.init(attributes)
        iconView.image = UIImage(named: "facebook_colored")
    }
    
    public required init?(coder: NSCoder)
    { super.init(coder: coder) }
}
