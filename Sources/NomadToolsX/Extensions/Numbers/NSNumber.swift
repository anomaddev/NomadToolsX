//
//  NSNumber.swift
//  
//
//  Created by Justin Ackermann on 11/28/22.
//

import UIKit

public extension NSNumber {
    var int: Int        { self.intValue }
    var double: Double  { self.doubleValue }
    var float: Float    { self.floatValue }
    var cgfloat: CGFloat    { CGFloat(self.float) }
}

