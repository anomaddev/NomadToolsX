//
//  CollectionTableCell.swift
//  NomadTools
//
//  Created by Justin Ackermann on 6/22/22.
//

// Core iOS
import UIKit

// Utilities
import Cartography

struct CollectionTableCellModel: TableCellModel { }

class CollectionTableCell: TableCell {
    
    override class var cellId: String { "CollectionTableCell" }
    
    lazy var header: Header = Header([
        .font(.Medium, size: 18)
    ])
    
    lazy var seeall: Button = Button([
        .font(.Medium, size: 14),
        .text("See All"),
        .textColor(.onBackground)
    ])
      
    public var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    lazy var collection: UICollectionView = {
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 40
        
        let view = UICollectionView(frame: .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200), collectionViewLayout: layout)
        view.contentInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        view.backgroundColor = .surface
        view.showsHorizontalScrollIndicator = false
        
        return view
    }()
    
    func layout(model: CollectionTableCellModel) {
        super.layout(with: model)
        
        add(header, seeall, collection)
        constrain(header, seeall, collection)
        { header, seeall, collection in
            let superview = collection.superview!
            
            header.top == superview.top + 10
            header.left == superview.left + 15
        
            seeall.right == superview.right - 15
            seeall.centerY == header.centerY
            
            collection.top == header.bottom + 15
            collection.left == superview.left
            collection.right == superview.right
            collection.bottom == superview.bottom - 10
            collection.height == 200
        }
        
        sendSubviewToBack(contentView)
        layoutIfNeeded()
    }
}
