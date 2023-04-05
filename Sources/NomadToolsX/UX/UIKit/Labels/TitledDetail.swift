//
//  TitledDetail.swift
//  NomadTools
//
//  Created by Justin Ackermann on 3/26/22.
//

// Core iOS
import UIKit

// Utilities
import Cartography

// TODO: Implement Attributes

open class TitleDetail: UIView {
    
    lazy var column: Column = Column([
        .alignment(.fill),
        .distribution(.fill),
        .spacing(5)
    ])
    
    public lazy var _title: Header = Header(style: .H5, alignment: .center)
    public lazy var _detail: Header = Header(style: .H3, alignment: .center)
    
    public var title: String? {
        get { _title.text }
        set { _title.text = newValue }
    }
    
    public var detail: String? {
        get { _detail.text }
        set { _detail.text = newValue }
    }
    
    public init(_ style: TitleDetailStyle! = .TopBottom,
         title: String? = nil,
         detail: String? = nil) {
        super.init(frame: .zero)
        
        self.title = title
        self.detail = detail
        
        switch style {
        case .TopBottom:
            column.addArrangedSubview(_title)
            column.addArrangedSubview(_detail)
            
        case .BottomTop:
            column.addArrangedSubview(_detail)
            column.addArrangedSubview(_title)
        
        case .none: break
        }
        
        add(column)
        constrain(column, _title, _detail)
        { column, title, detail in
            let superview = column.superview!
            
            column.top ~== superview.top
            column.left ~== superview.left
            column.right ~== superview.right
            column.bottom ~== superview.bottom
        }
    }
    
 
    public enum TitleDetailStyle {
        case TopBottom
        case BottomTop
    }
    
    required public init?(coder: NSCoder)
    { super.init(coder: coder) }
}
