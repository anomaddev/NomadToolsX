//
//  RadioButtons.swift
//  NomadTools
//
//  Created by Justin Ackermann on 6/23/22.
//

// Core iOS
import UIKit

// Utilities
import NomadUI
import Cartography

protocol RadioButtonDelegate {
    
}

open class RadioButtons: UIView {
    
    lazy var column: Column = Column([
        .distribution(.fillEqually),
        .alignment(.fill),
        .spacing(5)
    ])
    
    public var active: Int = 0
    
    public init(items: [String], active index: Int) {
        super.init(frame: .zero)
        
        add(column)
        constrain(column)
        { col in
            let superview = col.superview!
            col.top ~== superview.top
            col.left ~== superview.left
            col.center ~== superview.center
        }
        
        self.active = index
        setRadios(items, active: index)
    }
    
    public func setRadios(_ items: [String], active: Int) {
        for (i, item) in items.enumerated() {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
            let radio = RadioButton(title: item)
            radio.button.backgroundColor = i == active ? .primary.color : .clear
            radio.tag = i
            radio.addGestureRecognizer(gesture)
            column.addArrangedSubview(radio)
        }
        layoutIfNeeded()
    }
    
    public func set(index: Int) throws {
        for radio in column.arrangedSubviews {
            guard let radio = radio as? RadioButton
            else { throw NSError() } // THROW:
            active = index
            radio.button.backgroundColor = index == radio.tag ? .primary.color : .clear
        }
        layoutIfNeeded()
    }
    
    @objc public func tapped(_ sender: UITapGestureRecognizer!) {
        active = sender.view?.tag ?? 0
        for button in column.subviews {
            if let btn = button as? RadioButton
            { btn.button.backgroundColor = sender.view?.tag == btn.tag ? .primary.color : .clear }
        }
    }
    
    required public init?(coder: NSCoder)
    { super.init(coder: coder) }
}

open class RadioButton: UIView {
    
    lazy var row: Row = Row([
        .distribution(.fill),
        .alignment(.center),
        .spacing(10),
        .setHeight(30)
    ])
    
    lazy var button: BlankView = BlankView([
        .setWidth(15),
        .setHeight(15),
        .cornerRadius(7.5),
        .borderColor(.primary.color),
        .borderWidth(2)
    ])
    
    lazy var label: Header = Header(style: .H4, color: .onBackground)
    
    public init(title: String) {
        super.init(frame: .zero)
        
        label.text = title
        
        row.addArrangedSubview(button)
        row.addArrangedSubview(label)
        
        add(row)
        constrain(row)
        { row in
            let superview = row.superview!
            row.top ~== superview.top
            row.left ~== superview.left + 15
            row.center ~== superview.center
        }
    }
    
    required public init?(coder: NSCoder)
    { super.init(coder: coder) }
}
