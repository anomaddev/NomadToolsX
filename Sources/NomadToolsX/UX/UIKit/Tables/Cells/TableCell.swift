//
//  TableCell.swift
//  NomadTools
//
//  Created by Justin Ackermann on 3/26/22.
//

// Core iOS
import UIKit

// Utilities
import NomadUI
import Cartography
import SwipeCellKit

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
        backgroundColor = .background.color
    }
}

open class SwipeableTableCell: SwipeTableViewCell {
    public static func getId() -> String { cellId }
    open class var cellId: String { return "swipecell" }
    
    public static func register(on table: UITableView)
    { table.register(self, forCellReuseIdentifier: cellId)}
    
    public static func dequeue(on table: UITableView, for index: IndexPath? = nil) -> SwipeableTableCell? {
        if let i = index { return table.dequeueReusableCell(withIdentifier: cellId, for: i) as? SwipeableTableCell }
        else { return table.dequeueReusableCell(withIdentifier: cellId) as? SwipeableTableCell }
    }
    
    open func layout(with model: TableCellModel) {
        selectionStyle = .none
        backgroundColor = .background.color
    }
}

public protocol TableCellModel {
    
}
