//
//  Speed.swift
//  NomadTools
//
//  Created by Justin Ackermann on 5/27/21.
//

import Foundation

// MARK: Actions
//extension Nomad {
//    /// Conversions
//    static func howFast(is speed: Speed,
//                        in unit: Speed.Unit) -> Speed {
//        return speed.converted(to: unit)
//    }
//
//    /// Calculations
//}

// MARK: Statements


// MARK: Speed
public class Speed {
    
    /// Variables
    private let originalValue: NSNumber
    private let originalUnit: Unit
    
    private var _value: NSNumber
    private var _unit: Unit
    
    public var value: Double
    { get { return _value.double }}
    
    public var unit: Unit
    { get { return _unit }}
    
    /// Quick Conversions
    
    /// Initialize
    public init(is number: Int,
                in unit: Unit! = .mps)
    {
        _value = NSNumber(value: number)
        _unit = unit
        
        originalValue = _value
        originalUnit = _unit
    }
    
    public init(is num: Double,
                in unit: Unit! = .mps)
    {
        _value = NSNumber(value: num)
        _unit = unit
        
        originalValue = _value
        originalUnit = _unit
    }
    
    /// Helpers
    private var baseline: Double
    { return _value.doubleValue * _unit.multiplier }
    
    public func converted(to unit: Unit) -> Speed {
        let value = baseline / unit.multiplier
        return Speed(is: value, in: unit)
    }
    
    public func convert(to unit: Unit) {
        let value = baseline / unit.multiplier
        _value = value.number
        _unit = unit
    }
    
    // TODO: More conversion, rounded etc
    public func labeled(styled: UnitLabelStyle,
                 in unit: Unit? = nil,
                 whitespace: Bool! = true) -> String {
        let value = converted(to: unit ?? _unit)
        let num = value.value.int
        let unit = value.unit
        return "\(num)\(unit.label(with: styled, whitespace: whitespace))"
    }
    
    // MARK: Units
    public enum Unit: String, Codable {
        
        // Imperial
        case fps
        case mph
        case kts
        
        case mach
        
        // Metric
        case mps
        case kmh
        
        internal var multiplier: Double {
            switch self {
                
            // Imperial
            case .fps: return 1.09728
            case .mph: return 1.60934
            case .kts: return 1.852
                
            case .mach: return 1234.8
                
            // Metric
            case .mps: return 3.6
            case .kmh: return 1
            }
        }
        
        public var labels: UnitStyleLabels {
            var labels: (String, String, String) {
                switch self {
                    
                // Imperial
                case .fps: return ("fps", "ft/sec", "feet per second")
                case .mph: return ("mph", "mi/hr", "miles per hour")
                case .kts: return ("kts", "kts.", "knots")
                    
                case .mach: return ("mach", "mach", "speed of sound")
                    
                // Metric
                case .mps: return ("m/s", "m/s", "meters per second")
                case .kmh: return ("kph", "km/hr", "kilometers per hour")
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
