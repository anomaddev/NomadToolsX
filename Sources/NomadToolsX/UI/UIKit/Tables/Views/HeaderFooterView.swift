//
//  HeaderFooterView.swift
//  NomadTools
//
//  Created by Justin Ackermann on 3/26/22.
//

// Core iOS
import UIKit

// Utilities
import Cartography

open class HeaderFooterView: UITableViewHeaderFooterView {
    public static func getId() -> String { id }
    open class var id: String { return "headerFooter" }
    
    public lazy var text: Header = Header(style: .H3, height: 20)
    public lazy var subtext: Header = Header(style: .H3, alignment: .right)
    
    public static func register(on table: UITableView)
    { table.register(self, forHeaderFooterViewReuseIdentifier: id)}
    
    public static func dequeue(on table: UITableView) -> HeaderFooterView?
    { return table.dequeueReusableHeaderFooterView(withIdentifier: id) as? HeaderFooterView }
    
    open func layout(with model: HeaderFooterViewModel) {
        
    }
    
    open func layout(with text: String? = nil,
                     sub subtext: String? = nil) {
        self.text.text = text
        self.subtext.text = subtext
        add(self.text, self.subtext)
        constrain(self.text, self.subtext)
        { text, sub in
            let superview = text.superview!
            text.left == superview.left + 15
            text.centerY == superview.centerY
            text.top == superview.top + 10
            
            sub.right == superview.right - 15
            sub.centerY == superview.centerY
        }
    }
}

public protocol HeaderFooterViewModel: Codable {
    
}
