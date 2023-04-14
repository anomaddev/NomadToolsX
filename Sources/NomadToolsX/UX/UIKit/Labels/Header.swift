//
//  Header.swift
//  NomadTools
//
//  Created by Justin Ackermann on 3/20/22.
//

import UIKit
import Cartography

public class Header: UILabel, Attributed {
    
    private var padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    public var defaultAttributes: [Attribute] = [
        .backgroundColor(.clear),
        .textAlignment(.left),
        .text(nil),
        .attributed(nil),
        .textColor(Nomad.theme.onBackground),
        .resize(false),
        .minimumTextScale(0.75)
    ]
    
    public init(_ text: String? = nil,
                style: HeaderStyle! = .H3,
                alignment: NSTextAlignment! = .left,
                color: UIColor! = .onBackground,
                height: CGFloat? = nil,
                width: CGFloat? = nil) {
        super.init(frame: .zero)
        overrideUserInterfaceStyle = .light
        setAttributes(defaultAttributes)
        
        var font: Font! = .Bold
        var size: CGFloat! = 16
        switch style {
        case .H1: font = Font.Bold; size = 32
        case .H2: font = Font.Medium; size = 24
        case .H3: font = Font.Bold; size = 18
        case .H4: font = Font.Medium; size = 16
        case .H5: font = Font.Bold; size = 14
        case .H6: font = Font.Medium; size = 14
        case .P(let s):
            font = Font.Regular; size = s
            numberOfLines = 0
        case .none: break
        }
        
        if let height = height
        { constrainHeight(height) }
        
        if let width = width
        { constrainWidth(width) }

        self.setAttributes([
            .font(font, size: size),
            .text(text),
            .textAlignment(alignment),
            .textColor(color)
        ])
    }
    
    public init(_ attributes: [Attribute]! = []) {
        super.init(frame: .zero)
        self.setAttributes(attributes)
    }
    
    public func setAttributes(_ attributes: [Attribute]) {
        setView(attributes)
        for attribute in attributes {
            switch attribute {
            case .text(let str):                text = str
            case .attributed(let attr):         attributedText = attr
            case .textColor(let color):         textColor = color
            case .textAlignment(let alignment): textAlignment = alignment
            case .minimumTextScale(let scale):  minimumScaleFactor = scale
            case .font(let ft, let size, let alt):       font = ft.getFont(size: size, alternative: alt)
            case .resize(let shouldSize):       adjustsFontSizeToFitWidth = shouldSize
            case .numberOfLines(let num):       numberOfLines = num
            case .padding(let top, let right, let bottom, let left):
                padding = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)

            default: break
            }
        }
        sizeToFit()
        layoutIfNeeded()
    }
    
    public override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    public override var intrinsicContentSize : CGSize {
        let superContentSize = super.intrinsicContentSize
        let width = superContentSize.width + padding.left + padding.right
        let heigth = superContentSize.height + padding.top + padding.bottom
        return CGSize(width: width, height: heigth)
    }
    
    required init?(coder: NSCoder)
    { super.init(coder: coder) }
    
    // STYLING:
    public enum HeaderStyle {
        
        /// Bold Size 32
        case H1
        
        /// Medium Size 24
        case H2
        
        /// Bold Size 18
        case H3
        
        /// Medium Size 16
        case H4
        
        /// Bold Size 14
        case H5
        
        /// Medium Size 14
        case H6
        
        /// Regular Font Weight
        /// - Parameter size: CGFloat font size
        case P(size: CGFloat)
    }
}
