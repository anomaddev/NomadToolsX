//
//  CLLocationCoordinate2D.swift
//  
//
//  Created by Justin Ackermann on 11/28/22.
//

import Foundation
import CoreLocation

public extension CLLocationCoordinate2D {
    func haversine(to coord: CLLocationCoordinate2D,
                   radius: Double = 6367444.7) -> Distance {
        let haversin = { (angle: Double) -> Double in
            return (1 - cos(angle))/2
        }
        
        let ahaversin = { (angle: Double) -> Double in
            return 2*asin(sqrt(angle))
        }
        
        // Converts from degrees to radians
        let dToR = { (angle: Double) -> Double in
            return (angle / 360) * 2 * .pi
        }
        
        let lat1 = dToR(self.latitude)
        let lon1 = dToR(self.longitude)
        let lat2 = dToR(coord.latitude)
        let lon2 = dToR(coord.longitude)
        
        let meters = radius * ahaversin(haversin(lat2 - lat1) + cos(lat1) * cos(lat2) * haversin(lon2 - lon1))
        return Distance(is: meters)
    }
    
    var location: CLLocation
    { CLLocation(latitude: latitude, longitude: longitude)}
}

extension Array where Element == CLLocationCoordinate2D {
    public func minMax() -> ((Double, Double), (Double, Double)) {
        // Lookup is done with one pass on array with only reduce
        return reduce((
            (.greatestFiniteMagnitude, -.greatestFiniteMagnitude),
            (.greatestFiniteMagnitude, -.greatestFiniteMagnitude)
        )) { r, c in
            (
                (Swift.min(c.latitude,r.0.0), Swift.max(c.latitude, r.0.1)),
                (Swift.min(c.longitude, r.1.0), Swift.max(c.longitude, r.1.1))
            )
        }
    }
}
