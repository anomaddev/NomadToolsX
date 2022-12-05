//
//  TableView.swift
//  NomadTools
//
//  Created by Justin Ackermann on 6/16/22.
//

// Core iOS
import UIKit

// Utilities
import Cartography

// TODO: Implement

open class TableView: UITableView, Attributed {
    public var defaultAttributes: [Attribute] = [
    
    ]
    
    public init(_ attributes: [Attribute]! = []) {
        super.init(frame: .zero, style: .plain)
        tableHeaderView = UIView()
        tableFooterView = UIView()
    }
    
    required public init?(coder: NSCoder)
    { super.init(coder: coder) }
}
