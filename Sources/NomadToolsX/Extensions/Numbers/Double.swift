//
//  Double.swift
//  
//
//  Created by Justin Ackermann on 11/28/22.
//

import UIKit

public extension Double {
    /// is an Int?
    var isInteger: Bool     { floor(self) == self }
    
    /// Base Conversions
    var int: Int            { Int(self) }
    var float: Float        { Float(self) }
    var cgfloat: CGFloat    { CGFloat(self) }
    var number: NSNumber    { NSNumber(value: self) }
    
    
    // MARK: Unit Conversions
    
    /// Degrees to Radians
    var radians: Double      { self * .pi / 180 }
    /// Radians to Degrees
    var degress: Double      { self * 180 / .pi }
    
    /// String representation
    var string: String
    { "\(self)" }
    
    // MARK: Transforms
    /// Rounds the double to decimal places value
    func rounded(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    /// Trucates the double to number of decimal places value
    func truncate(places: Int) -> Double {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
    
    func HMS() -> (Double, Double, Double) {
        let (hr,  minf) = modf(self / 3600)
        let (min, secf) = modf(60 * minf)
        return (hr, min, 60 * secf)
    }
}
