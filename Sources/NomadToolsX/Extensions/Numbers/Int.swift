//
//  Int.swift
//  
//
//  Created by Justin Ackermann on 11/28/22.
//

// Core iOS
import UIKit

// MARK: - Int
public extension Int {
    /// Facts
    var isEven: Bool { self % 2 == 0 }
    var isOdd: Bool { !isEven }
    
    /// Base Conversions
    var double: Double      { Double(self) }
    var float: Float        { Float(self) }
    var cgfloat: CGFloat    { CGFloat(self) }
    var number: NSNumber    { NSNumber(value: self) }
    
    /// Date Conversions
    var date: Date
    { return Date(timeIntervalSince1970: TimeInterval(self)) }
    
    var interval: TimeInterval
    { return TimeInterval(self) }
    
    var ordinal: String? {
        let ordinalFormatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .ordinal
            return formatter
        }()
        return ordinalFormatter.string(from: NSNumber(value: self))
    }
    
    /// Stringify's
    var string: String
    { "\(self)" }
    
    var stringify: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: self)) ?? "0"
    }
    
    var socialify: String {
        let num = abs(Double(self))
        let sign = (self < 0) ? "-" : ""

        switch num {
        case 1_000_000_000...:
            var formatted = num / 1_000_000_000
            formatted = formatted.truncate(places: 1)
            return "\(sign)\(formatted)B"

        case 1_000_000...:
            var formatted = num / 1_000_000
            formatted = formatted.truncate(places: 1)
            return "\(sign)\(formatted)M"

        case 1_000...:
            var formatted = num / 1_000
            formatted = formatted.truncate(places: 1)
            return "\(sign)\(formatted)K"

        case 0...:
            return "\(self)"

        default:
            return "\(sign)\(self)"

        }
    }
    
    /// Time
    func HMS() -> (Int, Int, Int)
    { return (self / 3600, (self % 3600) / 60, (self % 3600) % 60) }
}

// MARK: - Int64
public extension Int64 {
    var int: Int
    { Int(self) }
}
