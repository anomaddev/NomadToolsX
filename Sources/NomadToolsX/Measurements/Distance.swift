//
//  Distance.swift
//  
//
//  Created by Justin Ackermann on 11/25/22.
//

import Foundation
import CoreLocation

// MARK: Distance
public class Distance {
    
    // MARK: Variables
    private let originalValue: NSNumber
    private let originalUnit: Unit
    
    private var _value: NSNumber
    private var _unit: Unit
    
    public var value: Double
    { get { return _value.double }}
    
    public var unit: Unit
    { get { return _unit }}
    
    /// Quick Conversions
    public var meters: Double
    { converted(to: .meters).value }
    
    public var kilometers: Double
    { converted(to: .kilometers).value }
    
    public var miles: Double
    { converted(to: .miles).value }
    
    public var nautical: Double
    { converted(to: .nautical).value }
    
    /// Initialize
    public init(is number: Int! = 0,
                in unit: Unit! = .meters)
    {
        _value = NSNumber(value: number)
        _unit = unit
        
        originalValue = _value
        originalUnit = _unit
    }
    
    public init(is num: Double,
                in unit: Unit! = .meters)
    {
        _value = NSNumber(value: num)
        _unit = unit
        
        originalValue = _value
        originalUnit = _unit
    }
    
    public init(from: CLLocationCoordinate2D,
                to: CLLocationCoordinate2D) {
        let dist = from.haversine(to: to)
        _value = dist._value
        _unit = dist._unit
        
        originalValue = _value
        originalUnit = _unit
    }
    
    /// Helpers
    private var baseline: Double
    { return _value.doubleValue * _unit.multiplier }
    
    public func converted(to unit: Unit) -> Distance {
        let value = baseline / unit.multiplier
        return Distance(is: value, in: unit)
    }
    
    public func convert(to unit: Unit) {
        let value = baseline / unit.multiplier
        _value = value.number
        _unit = unit
    }
    
    public func add(distance: Distance) {
        let value = distance.converted(to: _unit).value
        self._value = (value + self.value).number
    }
    
    public func adding(distance: Distance) -> Distance {
        let value = distance.converted(to: _unit).value
        return Distance(is: value + self._value.double, in: _unit)
    }
    
    // TODO: More conversion, rounded etc
    public func labeled(styled: UnitLabelStyle,
                        in unit: Unit? = nil,
                        whitespace: Bool! = true,
                        truncate: Int! = 2) -> String {
        let value = converted(to: unit ?? _unit)
        let num = value.value.truncate(places: truncate)
        let u = value.unit
        return "\(num)\(u.label(with: styled, whitespace: whitespace))"
    }
    
    // MARK: Units
    public enum Unit: String, Codable {
        
        // Imperial
        case feet
        case yards
        case miles
        case nautical
        
        // Metric
        case centimeter
        case meters
        case kilometers
        
        internal var multiplier: Double {
            switch self {
                
            // Imperial
            case .feet: return 0.3048
            case .yards: return 0.9144
            case .miles: return 1609.34
            case .nautical: return 1852
                
            // Metric
            case .centimeter: return 0.1
            case .meters: return 1
            case .kilometers: return 1000
            }
        }
        
        internal var labels: UnitStyleLabels {
            var labels: (String, String, String) {
                switch self {
                    
                // Imperial
                case .feet: return ("ft", "ft.", "feet")
                case .yards: return ("yd", "yd.", "yards")
                case .miles: return ("mi", "mi.", "miles")
                case .nautical: return ("nm", "nm.", "nautical miles")
                    
                // Metric
                case .centimeter: return ("cm", "cm.", "centimeters")
                case .meters: return ("m", "m", "meters")
                case .kilometers: return ("km", "km.", "kilometers")
                }
            }
            return UnitStyleLabels(compact: labels.0,
                                   short: labels.1,
                                   full: labels.2)
        }
        
        public func label(with style: UnitLabelStyle,
                          whitespace: Bool! = true) -> String {
            var r: String
            switch style {
            case .compact,
                 .brief: r = labels.compact
            case .short: r = labels.short
            case .full: r = labels.full
            }
            return (whitespace ? " " : "") + r
        }
    }
}

public extension Int {
    /// Distance
    var feet: Distance
    { Distance(is: self, in: .feet) }
    
    var meters: Distance
    { Distance(is: self, in: .meters) }
    
    var kilometers: Distance
    { Distance(is: self, in: .kilometers) }
    
    var miles: Distance
    { Distance(is: self, in: .miles) }
    
    var nautical: Distance
    { Distance(is: self, in: .nautical) }
}
