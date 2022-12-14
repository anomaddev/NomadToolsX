//
//  IconButton.swift
//  NomadTools
//
//  Created by Justin Ackermann on 3/20/22.
//

// Core iOS
import UIKit

// Utilities
import Cartography

open class IconButton: NomadView {
    
    lazy var row: Row = Row([.distribution(.fill), .alignment(.center), .spacing(10)])
    public lazy var icon: ImageView = ImageView()
    public lazy var header: Header = Header([.font(.Bold, size: 16), .resize(true), .numberOfLines(1), .textAlignment(.center)])
    public lazy var blank: BlankView = BlankView([.backgroundColor(.clear)])
    
    private var height: NSLayoutConstraint!
    private var image: Image!
    
    private var _text: String?
    public var text: String? {
        set {
            header.text = newValue
            _text = newValue
        }
        get { _text }
    }
    
    private var _color: UIColor?
    public var color: UIColor? {
        set {
            backgroundColor = newValue
            _color = newValue
        }
        get { _color }
    }
    
    public init(_ attributes: [Attribute], alignment: NSTextAlignment! = .center) {
        super.init(frame: .zero)
        layer.borderWidth = 2
        layer.borderColor = UIColor.clear.cgColor
        
        row.addArrangedSubview(icon)
        row.addArrangedSubview(header)
        row.addArrangedSubview(blank)
        
        add(row)
        constrain(row, icon, header, blank)
        { row, icon, header, blank in
            let superview = row.superview!
            row.top ~== superview.top + 5
            row.centerY ~== superview.centerY
            
            height = icon.height ~== superview.height / 2
            icon.width ~== icon.height
            
            header.centerY ~== icon.centerY
            header.height ~== superview.height
            icon.centerY ~== superview.centerY
            
            blank.height ~== icon.height
            blank.width ~== icon.width
            
            switch alignment {
            case .left, .right:
                row.left ~== superview.left + 15
                row.right ~== superview.right - 15
                
            case .center:
                row.centerX ~== superview.centerX
                
            default: break
            }
        }
        
        layoutIfNeeded()
        row.addArrangedSubview(Spacer(w: icon.frame.width))
        
        do { set(attributes) }
    }
    
    public func set(_ attributes: [Attribute]) {
        setView(attributes)
        attributes.forEach {
            switch $0 {
            case .backgroundColor(let clr): color = clr
            case .contentMode(let mode): icon.contentMode = mode
            case .iconSize(let size):
                height.constant = size.height
                
            case .image(let img): icon.image = img
                
            case .icon(let i, let clr):
                icon.image = i.tint()
                image = i
                
            case .text(let str): text = str
            case .textColor(let clr): header.textColor = clr
            case .font(let font, let size):
                header.font = font.getFont(size: size)
            default: break
            }
        }
    }
    
    public func set(attribute: Attribute) {
        set([attribute])
    }
    
    required public init?(coder: NSCoder)
    { super.init(coder: coder) }
}

