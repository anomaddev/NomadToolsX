//
//  Button.swift
//  NomadTools
//
//  Created by Justin Ackermann on 3/21/22.
//

// Core iOS
import UIKit

// Utilities
import Cartography

open class Button: UIButton, Attributed {
    public var defaultAttributes: [Attribute] = [
        .borderWidth(0),
        .borderColor(.clear),
        .textColor(.onBackground)
    ]
    
    public var toggled: Bool! = false
    { didSet {
        if toggled { rotate(degrees: -90) }
        else { rotate(degrees: 90) }
    }}
    
    public init(_ attributes: [Attribute]) {
        super.init(frame: .zero)
        setAttributes(defaultAttributes + attributes)
    }
    
    public func setAttributes(_ attributes: [Attribute]) {
        setView(attributes)
        attributes.forEach {
            switch $0 {
            case .font(let font, let size, let alt):
                titleLabel?.font = font.getFont(size: size, alternative: alt)
                
            case .text(let txt): setTitle(txt, for: .normal)
            case .selectedText(let txt): setTitle(txt, for: .selected)
                
            case .textColor(let color): setTitleColor(color, for: .normal)
            case .selectedColor(let color): setTitleColor(color, for: .selected)
                
            case .icon(let img, let color, let rotated):
                setImage(img.image, for: .normal)
                
                if let rotated = rotated
                { setImage(img.image?.rotate(degrees: rotated), for: .normal) }
                
                if let color = color
                { tintColor = color }
                
            case .image(let img): setImage(img, for: .normal)
            case .asset(let img, let color, let rotated):
                setImage(img.image, for: .normal)
                
                if let rotated = rotated
                { setImage(img.image?.rotate(degrees: rotated), for: .normal) }
                
                if let color = color
                { tintColor = color }
                
            case .insets(let insets): imageEdgeInsets = insets
            case .numberOfLines(let lines): titleLabel?.numberOfLines = lines
            case .tintColor(let color): tintColor = color
                
            default: break
            }
        }
    }
    
    private func rotate(degrees: Float! = 0) {
        Nomad.main.async {
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
                self.transform = self.transform.rotated(by: degrees.radians.cgfloat)
            })
        }
    }
    
    required public init?(coder: NSCoder)
    { super.init(coder: coder) }
}
