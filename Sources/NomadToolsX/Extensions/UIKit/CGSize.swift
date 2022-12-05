//
//  CGSize.swift
//  NomadTools_Example
//
//  Created by Justin Ackermann on 5/27/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

public extension CGSize {
    static func square(_ size: CGFloat) -> CGSize {
        return CGSize(width: size, height: size)
    }
    
    static func rectangle(_ x: CGFloat,_ y: CGFloat) -> CGSize {
        return CGSize(width: x, height: y)
    }
}
