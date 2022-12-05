//
//  SpreadsheetView.swift
//  NomadTools
//
//  Created by Justin Ackermann on 3/24/22.
//

// Core iOS
import UIKit

// Utilities
import Cartography

// TODO: Finish This

public protocol SpreadsheetDelegate {
    
    func spreadsheet(_ spreadsheet: SpreadsheetView,_ column: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    
    func numberOfRows(_ spreadsheet: SpreadsheetView) -> Int
    func numberOfColumns(_ spreadsheet: SpreadsheetView) -> Int
    
    func headerView(_ spreadsheet: SpreadsheetView) -> UIView?
    func heightForHeaderView(_ spreadsheet: SpreadsheetView) -> CGFloat
    
    func footerView(_ spreadsheet: SpreadsheetView) -> UIView?
    func heightForFooterView(_ spreadsheet: SpreadsheetView) -> CGFloat
    
    func heightForRow(_ spreadsheet: SpreadsheetView, at indexPath: IndexPath) -> CGFloat?
}

public class SpreadsheetView: UIView {
    
    public lazy var sheet: Row = Row([
        .alignment(.fill),
        .distribution(.fillEqually),
        .spacing(-2)
    ])
    
    private var headerView: UIView!
    private var footerView: UIView!
    
    public var delegate: SpreadsheetDelegate?
    
    public init() {
        super.init(frame: .zero)
        backgroundColor = .surface
    }
    
    public func reloadSheet() {
        headerView?.removeFromSuperview()
        footerView?.removeFromSuperview()
        sheet.arrangedSubviews.forEach
        { $0.removeFromSuperview() }
        
        let header = delegate?.headerView(self) ?? Spacer(h: 0)
        let footer = delegate?.footerView(self) ?? Spacer(h: 0)
        
        add(header, sheet, footer)
        constrain(header, sheet, footer)
        { header, sheet, footer in
            let superview = sheet.superview!
            header.top == superview.top
            header.width == superview.width
            header.centerX == superview.centerX
            header.height == delegate?.heightForHeaderView(self) ?? 0
            
            sheet.top == header.bottom - 2
            sheet.left == superview.left
            sheet.right == superview.right
            
            footer.top == sheet.bottom
            footer.width == superview.width
            footer.centerX == superview.centerX
            footer.height == delegate?.heightForFooterView(self) ?? 0
            
            footer.bottom == superview.bottom
        }
        
        guard let columns = delegate?.numberOfColumns(self), columns > 0
        else { return }
        for col in 0...(columns - 1) {
            let table = UITableView()
            table.tag = col
            table.separatorStyle = .none
            table.isScrollEnabled = false
            table.showsVerticalScrollIndicator = false
            table.showsHorizontalScrollIndicator = false
            table.layer.cornerRadius = 10
            table.layer.maskedCorners = {
                switch col {
                case 0: return [.layerMinXMaxYCorner]
                case (columns - 1): return [.layerMaxXMaxYCorner]
                default: return []
                }
            }()
            
            table.layer.borderColor = .onBackground
            table.layer.borderWidth = 2
            table.delegate = self
            table.dataSource = self
            table.register(SpreadsheetCell.self, forCellReuseIdentifier: SpreadsheetCell.cellId)
            table.reloadData()
            sheet.addArrangedSubview(table)
        }
        
        layoutIfNeeded()
    }
    
    required init?(coder: NSCoder)
    { super.init(coder: coder) }
}

extension SpreadsheetView: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    { return delegate?.numberOfRows(self) ?? 0 }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    { return delegate?.spreadsheet(self, tableView, cellForRowAt: indexPath) ?? UITableViewCell() }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    { return delegate?.heightForRow(self, at: indexPath) ?? 40 }
}

public class SpreadsheetCell: UITableViewCell {
    public static let cellId: String = "SpreadsheetCell"
    
    public lazy var value: Header = Header(style: .H2, alignment: .center)
    
    public func setup(_ text: String? = nil) {
        backgroundColor = .clear
        selectionStyle = .none
        value.layer.borderColor = .onBackground
        value.layer.borderWidth = 2
        value.text = text
        value.adjustsFontSizeToFitWidth = true
        value.minimumScaleFactor = 0.75
        add(value)
        constrain(value)
        { value in
            let superview = value.superview!
            value.top == superview.top - 1
            value.left == superview.left
            value.center == superview.center
        }
    }
}
