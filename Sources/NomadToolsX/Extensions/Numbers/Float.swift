//
//  Float.swift
//  
//
//  Created by Justin Ackermann on 11/26/22.
//

import UIKit

// MARK: - Float
public extension Float {
    /// Base Conversions
    var int: Int            { Int(self) }
    var double: Double      { Double(self) }
    var cgfloat: CGFloat    { CGFloat(self) }
    var number: NSNumber    { NSNumber(value: self) }
    
    /// Unit Conversions
    var radians: Float      { self * .pi / 180 }
    var degress: Float      { self * 180 / .pi }
    
    /// Strings
    var string: String
    { "\(self)" }
    
    /// Transforms
    func rounded(to places: Int) -> Double {
        // TODO: Implement
        return 0
    }
}

// MARK: - CGFloat
public extension CGFloat {
    /// Base Conversions
    var int: Int          { Int(self) }
    var double: Double      { Double(self) }
    var float: Float        { Float(self) }
    var number: NSNumber    { NSNumber(value: float) }
    
    /// Unit Conversions
    var radians: CGFloat      { self * .pi / 180 }
    var degress: CGFloat      { self * 180 / .pi }
    
    /// Strings
    var string: String
    { "\(self)" }
    
    /// Transforms
    func rounded(to places: Int) -> Double {
        // TODO: Implement
        return 0
    }
}
