//
//  Date.swift
//  
//
//  Created by Justin Ackermann on 11/28/22.
//

import Foundation

#if !os(macOS)
extension Date {
    
    
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
    
    public var since1970: Int
    { Int(self.timeIntervalSince1970) }
    
    
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
}
#endif
