//
//  StackView.swift
//  NomadTools
//
//  Created by Justin Ackermann on 3/21/22.
//

import UIKit

import Cartography

open class NomadicStackView: UIStackView, Attributed {
    public var defaultAttributes: [Attribute] = [
        .distribution(.fillProportionally),
        .alignment(.center),
        .spacing(5)
    ]
    
    public init(_ attributes: [Attribute]! = []) {
        super.init(frame: .zero)
        setAttributes(defaultAttributes)
        setAttributes(attributes)
    }
    
    public func setAttributes(_ attributes: [Attribute]) {
        setView(attributes)
        attributes.forEach {
            switch $0 {
            case .distribution(let dist): distribution = dist
            case .alignment(let align): alignment = align
            case .spacing(let space): spacing = space
            case .axis(let ax): axis = ax
            default: break
            }
        }
        layoutIfNeeded()
    }
    
    required public init(coder: NSCoder)
    { super.init(coder: coder) }
}

open class Row: NomadicStackView {
    public init(_ attributes: [Attribute])
    { super.init(attributes + [.axis(.horizontal)]) }
    
    required public init(coder: NSCoder)
    { super.init(coder: coder) }
}

open class Column: NomadicStackView {
    public init(_ attributes: [Attribute])
    { super.init(attributes + [.axis(.vertical)]) }
    
    required public init(coder: NSCoder)
    { super.init(coder: coder) }
}
