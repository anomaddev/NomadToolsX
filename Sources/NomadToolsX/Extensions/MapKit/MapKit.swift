//
//  MapKit.swift
//  Atlas
//
//  Created by Justin Ackermann on 9/4/20.
//  Copyright © 2020 Justin Ackermann. All rights reserved.
//

// Core iOS
import UIKit
import CoreLocation
import MapKit

// MARK: MKCoordinateRegion
public extension MKCoordinateRegion {
    
    // Bounding Box Coordinates
    var boundingBoxCoordinates: [CLLocationCoordinate2D] {
        let halfLatDelta = self.span.latitudeDelta / 2
        let halfLngDelta = self.span.longitudeDelta / 2

        let topLeft = CLLocationCoordinate2D(
            latitude: self.center.latitude + halfLatDelta,
            longitude: self.center.longitude - halfLngDelta
        )
        let bottomRight = CLLocationCoordinate2D(
            latitude: self.center.latitude - halfLatDelta,
            longitude: self.center.longitude + halfLngDelta
        )
        let bottomLeft = CLLocationCoordinate2D(
            latitude: self.center.latitude - halfLatDelta,
            longitude: self.center.longitude - halfLngDelta
        )
        let topRight = CLLocationCoordinate2D(
            latitude: self.center.latitude + halfLatDelta,
            longitude: self.center.longitude + halfLngDelta
        )

        return [topLeft, topRight, bottomRight, bottomLeft]
    }
}
