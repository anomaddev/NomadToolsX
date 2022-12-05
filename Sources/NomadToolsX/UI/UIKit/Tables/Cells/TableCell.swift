//
//  TableCell.swift
//  NomadTools
//
//  Created by Justin Ackermann on 3/26/22.
//

// Core iOS
import UIKit

// Utilities
import Cartography

open class TableCell: UITableViewCell {
    public static func getId() -> String { cellId }
    open class var cellId: String { return "cell" }
    
    public static func register(on table: UITableView)
    { table.register(self, forCellReuseIdentifier: cellId)}
    
    public static func dequeue(on table: UITableView, for index: IndexPath? = nil) -> TableCell? {
        if let i = index { return table.dequeueReusableCell(withIdentifier: cellId, for: i) as? TableCell }
        else { return table.dequeueReusableCell(withIdentifier: cellId) as? TableCell }
    }
    
    open func layout(with model: TableCellModel) {
        selectionStyle = .none
        backgroundColor = .background
    }
}

public protocol TableCellModel {
    
}
