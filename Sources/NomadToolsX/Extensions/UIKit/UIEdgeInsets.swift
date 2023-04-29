//
//  UIEdgeInsets.swift
//  
//
//  Created by Justin Ackermann on 4/28/23.
//

import UIKit

public extension UIEdgeInsets {
    
    static func vertical(_ padding: CGFloat! = 10) -> UIEdgeInsets
    { return .init(top: padding, left: 0, bottom: padding, right: 0) }
    
    static func horizontal(_ padding: CGFloat! = 10) -> UIEdgeInsets
    { return .init(top: 0, left: padding, bottom: 0, right: padding) }
    
    static func surrounding(_ padding: CGFloat! = 10) -> UIEdgeInsets
    { return .init(top: padding, left: padding, bottom: padding, right: padding) }
    
    static func surrounding(vertical: CGFloat! = 10, horizontal: CGFloat! = 10) -> UIEdgeInsets
    { return .init(top: vertical, left: horizontal, bottom: vertical, right: horizontal) }
}
