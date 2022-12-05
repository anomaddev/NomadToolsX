//
//  ButtonCell.swift
//  NomadTools
//
//  Created by Justin Ackermann on 6/19/22.
//

// Core iOS
import UIKit

// Utilities
import Cartography

open class ButtonCell: TableCell {
    
    override open class var cellId: String { "ButtonCell" }
    
    public lazy var button: Button = Button([
        .setHeight(40),
        .borderWidth(2),
        .borderColor(.primary),
        .textColor(.primary),
        .cornerRadius(5)
    ])
    
    public func setup(title: String,
                      style: ButtonHeaderFooterView.Style! = .Bordered(),
                      padding: UIEdgeInsets! = .init(top: 10, left: 20, bottom: 5, right: 20)) {
        switch style {
        case .Bordered(let color,
                       let borderWidth,
                       let radius):
            button.backgroundColor = .clear
            button.layer.borderWidth = borderWidth!
            button.layer.borderColor = color!.cgColor
            button.layer.cornerRadius = radius!
            button.setTitleColor(color, for: .normal)
            
        case .Filled(let color,
                     let textColor,
                     let radius):
            button.backgroundColor = color
            button.layer.cornerRadius = radius!
            button.setTitleColor(textColor, for: .normal)
            
        default: return
        }
        
        button.setTitle(title, for: .normal)
        
        add(button)
        constrain(button)
        { button in
            let superview = button.superview!
            button.top == superview.top + padding.top
            button.left == superview.left + padding.left
            button.right == superview.right - padding.right
            button.bottom == superview.bottom - padding.bottom
        }
        
        layoutIfNeeded()
    }
    
    public enum Style {
        case Bordered(color: UIColor! = .primary,
                      borderWidth: CGFloat! = 2,
                      radius: CGFloat! = 5)
        
        case Filled(color: UIColor! = .primary,
                    textColor: UIColor! = .onPrimary,
                    radius: CGFloat! = 5)
    }
}
