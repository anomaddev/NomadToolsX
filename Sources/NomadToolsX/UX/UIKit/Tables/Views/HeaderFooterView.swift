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
    
    public lazy var row: Row = Row([
        .distribution(.fill),
        .alignment(.center),
        .spacing(10)
    ])
    
    public var titleView: Header!
    public lazy var subtitleView: Header = Header(style: .H3, alignment: .right)
    
    public static func register(on table: UITableView)
    { table.register(self, forHeaderFooterViewReuseIdentifier: id)}
    
    public static func dequeue(on table: UITableView) -> HeaderFooterView?
    { return table.dequeueReusableHeaderFooterView(withIdentifier: id) as? HeaderFooterView }
    
    override open func prepareForReuse() {
        super.prepareForReuse()
        row.arrangedSubviews.forEach {
            row.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
    }
    
    open func layout(title: String? = nil,
                     subtitle: String? = nil,
                     insets: UIEdgeInsets? = .surrounding(vertical: 5, horizontal: 15),
                     style header: Header.HeaderStyle! = .H3) {
        titleView = Header(title, style: header, height: 20)
        subtitleView.text = subtitle
        
        row.addArrangedSubview(titleView)
        row.addArrangedSubview(subtitleView)
        row.fitTo(self, padding: insets)
        
        layoutIfNeeded()
    }
}

public protocol HeaderFooterViewModel: Codable {
    
}
