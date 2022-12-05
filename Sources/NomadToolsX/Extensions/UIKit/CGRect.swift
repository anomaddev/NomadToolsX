//
//  CGRect.swift
//  NomadTools_Example
//
//  Created by Justin Ackermann on 5/27/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

extension CGRect {
    public static func square(_ size: CGFloat) -> CGRect {
        return CGRect(x: 0, y: 0, width: size, height: size)
    }
    
    public static func rect(_ x: CGFloat,_ y: CGFloat) -> CGRect {
        return CGRect(x: 0, y: 0, width: x, height: y)
    }
    
    public var minEdge: CGFloat {
        return min(width, height)
    }
}
