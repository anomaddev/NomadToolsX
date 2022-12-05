//
//  Date.swift
//  NomadTools
//
//  Created by Justin Ackermann on 5/27/21.
//

import Foundation
import CoreLocation

// Utilities
import SwiftDate

public extension Date {
    
    /// Get start and end time for the day of the year
    /// - Parameters:
    ///   - day: nth day of year required
    ///   - year: year
    ///   - timezone: TimeZone of date point requested
    /// - Returns: Tuple containing the Start Date and End Date
    public static func day(_ day: Int,
                           of year: Int,
                           in timezone: TimeZone! = TimeZone(secondsFromGMT: 0)) throws -> (Date, Date) {
        var calendar = Calendar.current
        calendar.timeZone = timezone
        
        var startOfDay = DateComponents()
        startOfDay.year = year
        startOfDay.day = day
        startOfDay.hour = 0
        startOfDay.minute = 0
        
        guard let start = calendar.date(from: startOfDay)
        else { throw NSError() } // { throw AeroAPIError.startDateCreationInvalid }
                                 // THROW:
        
        var endOfDay = DateComponents()
        endOfDay.year = year
        endOfDay.day = day + 1
        endOfDay.hour = 0
        endOfDay.minute = 0
        
        guard let end = calendar.date(from: endOfDay)
        else { throw NSError() } // { throw AeroAPIError.endDateCreationInvalid }
                                 // THROW:
        
        return (start, end)
    }
    
    /// Get day of year of date in given time zone
    /// - Parameter timezone: TimeZone
    /// - Returns: Number of day of year in the specified TimeZone
    public func dayOfYear(in timezone: TimeZone! = TimeZone(secondsFromGMT: 0)) throws -> Int {
        var calendar = Calendar.current
        calendar.timeZone = timezone
        
        guard let day = calendar.ordinality(of: .day, in: .year, for: self)
        else { throw NSError() } // THROW:
        return day
    }
    
    /// Get year of date in the given time zone
    /// - Parameter timezone: TimeZone
    /// - Returns: Year for the day of the Date in specified TimeZone
    public func year(in timezone: TimeZone! = TimeZone(secondsFromGMT: 0)) throws -> Int {
        let formatter = DateFormatter()
        formatter.timeZone = timezone
        formatter.dateFormat = "yyyy"
        
        let string = formatter.string(from: self)
        guard let int = Int(string)
        else { throw NSError() } // THROW:
        
        return int
    }
    
    
    /// Convert Date to the give string format
    /// - Parameters:
    ///   - format: String representation of date
    ///   - timeZone: TimeZone for requested date representation
    /// - Returns: Date represented as string for the Time Zone specified
    public func toFormat(_ format: String,
                         in timeZone: TimeZone! = .init(abbreviation: "GMT")) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = timeZone
        return formatter.string(from: self)
    }
    
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }
    
    var since1970: Double
    { timeIntervalSince1970 }
    
    var seconds: Int
    { timeIntervalSince1970.int }
    
    var year: Int
    { Calendar.current.component(.year, from: self) }
    
    var startOfDay: Date {
        var calendar = Calendar.current
        calendar.timeZone = .init(abbreviation: "GMT") ?? .current
        return calendar.startOfDay(for: self)
    }
    
    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: self)!
    }
    
    func endOfDay(at coord: CLLocationCoordinate2D) throws -> (Date, TimeZone) {
        guard let timezone = TimezoneMapper.latLngToTimezone(coord)
        else { throw NSError() } // THROW: coordinateTimezoneInvalid
        
        var calendar = Calendar.current
        calendar.timeZone = timezone
        
        let format = DateFormatter()
        format.timeZone = .init(abbreviation: "GMT")
        format.dateFormat = "d"
        
        guard let tday = Int(format.string(from: self))
        else { throw NSError() } // THROW: timezoneDayCreationFailure
        
        var components = DateComponents()
        components.day = tday
        components.month = month
        components.year = year
        components.hour = 23
        components.minute = 59
        components.second = 59
        
        guard let end = calendar.date(from: components)
        else { throw NSError() } // THROW: endDateCreationInvalid
        
        return (end, timezone)
    }
    
    func startOfDay(at coord: CLLocationCoordinate2D,
                  from zone: TimeZone! = .init(abbreviation: "GMT")) throws -> (Date, TimeZone) {
                
        guard let timezone = TimezoneMapper.latLngToTimezone(coord)
        else { throw NSError() } // THROW: coordinateTimezoneInvalid
        
        var calendar = Calendar.current
        calendar.timeZone = timezone
        
        var components = self.get(.day, .month, .year)
        components.hour = 0
        components.minute = 0
        
        guard let start = calendar.date(from: components)
        else { throw NSError() } // THROW: startDateCreationInvalid
    
        return (start, timezone)
    }
    
    func dayOfYear(for coord: CLLocationCoordinate2D) throws -> Int {
        guard let timezone = TimezoneMapper.latLngToTimezone(coord)
        else { throw NSError() } // THROW: coordinateTimezoneInvalid
        
        var calendar = Calendar.current
        calendar.timeZone = timezone
        
        guard let day = calendar.ordinality(of: .day, in: .year, for: self)
        else { throw NSError() }
        return day
    }
    
    var dayOfYear: Int
    { return Calendar.current.ordinality(of: .day, in: .year, for: self)! }
    
    var daySuffix: String {
        let calendar = Calendar.current
        let dayOfMonth = calendar.component(.day, from: self)
        switch dayOfMonth {
        case 1, 21, 31: return "st"
        case 2, 22: return "nd"
        case 3, 23: return "rd"
        default: return "th"
        }
    }
    
    func timeAt(_ coord: CLLocationCoordinate2D,
                in format: TimeFormat! = .HoursMinutes) -> String {
        let zone = TimezoneMapper.latLngToTimezone(coord)
        let toFormatter = DateFormatter()
        toFormatter.timeZone = zone
        toFormatter.dateFormat = format.rawValue
        return toFormatter.string(from: self)
    }
    
    func printout() {
        print(self)
        print("------")
        print("Time: \(self.toFormat("h:mm a"))")
        print("Date: \(self.toFormat("MMM d, yyyy"))")
        print("Full: \(self.toFormat("E, d MMM yyyy HH:mm:ss Z"))")
        print("Timezone: \(self.toFormat("zzzz"))")
        print("------")
    }
    
//    func toFormat(_ format: String, in timeZone: TimeZone! = .current) -> String {
//        let formatter = DateFormatter()
//        formatter.calendar = .current
//        formatter.dateFormat = format
//        formatter.timeZone = timeZone
//        return formatter.string(from: self)
//    }
    
    func toFormat(time format: TimeFormat) -> String
    { return toFormat(format.rawValue) }
    
    // Check Date
    
    func olderThanAWeek() -> Bool
    { return self.since1970 < (Date() - 7.days).since1970 }
    
    // Firestore
//    var timestamp: Timestamp
//    { Timestamp(date: self) }
}
 // MOVEOUT:
public enum TimeFormat: String {
    case HoursMilitaryZone              = "HH:mm zzz"
    case HoursMilitary                  = "HH:mm"
    case HoursMinutes                   = "h:mm a"
    case HoursMinutesZone               = "h:mm a zzz"
    case MonDayHoursMinutes             = "MMM d, h:mm a"
    case Month                          = "MMMM"
    case Mon                            = "MMM"
    case Day                            = "d"
    case Year                           = "yyyy"
    case DayOfWeek                      = "EEEE"
    case MonDay                         = "MMM d"
    case MonthDay                       = "MMMM d"
    case MonthDayYear                   = "MMMM d, yyyy"
    case DayYear                        = "d yyyy"
    case MonYear                        = "MMM yyyy"
    case MonthYear                      = "MMMM yyyy"
    case MonDayYear                     = "MMM d, yyyy"
    case MonYearHoursMinutes            = "MMM d, yyyy h:mm a"
    case MonYearHoursMinutesZone        = "MMM d, yyyy h:mm a zzz"
    case DayOfWeekDateYear              = "EEEE, MMM d, yyyy"
    case HoursMinutesSecondsMilli       = "HH:mm:ss.SS"
    case MinutesSecondsMilli            = "mm:ss.SS"
    case SecondsMilli                   = "ss.SS"
}

