//
//  MKMapView.swift
//  Atlas
//
//  Created by Justin Ackermann on 9/3/20.
//  Copyright © 2020 Justin Ackermann. All rights reserved.
//

import UIKit
import MapKit

// MARK: MKMapView
public extension MKMapView {
    // Auto Zoom Max Overlays Shown
    open func autozoom(_ padding: CGFloat! = 50, animated: Bool! = true) {
        if let first = self.overlays.first {
            let rect = self.overlays.reduce(first.boundingMapRect, { $0.union($1.boundingMapRect) })
            self.setVisibleMapRect(rect,
                                   edgePadding: UIEdgeInsets(top: padding, left: padding, bottom: padding + 30, right: padding),
                                   animated: animated)
        }
    }
    
    open func autozoom(with insets: UIEdgeInsets, animated: Bool! = true) {
        if let first = self.overlays.first {
            let rect = self.overlays.reduce(first.boundingMapRect, { $0.union($1.boundingMapRect) })
            self.setVisibleMapRect(rect,
                                   edgePadding: UIEdgeInsets(top: insets.top, left: insets.left, bottom: insets.bottom, right: insets.right),
                                   animated: animated)
        }
    }
    
    // Limit Zoom Level
    open func limit(from min: Double! = 0.01, to max: Double! = 4) {
        let coordinate = CLLocationCoordinate2DMake(self.region.center.latitude, self.region.center.longitude)
        var span = self.region.span
        if span.latitudeDelta < min
        { span = MKCoordinateSpan(latitudeDelta: min, longitudeDelta: min) }
        else if span.latitudeDelta > max
        { span = MKCoordinateSpan(latitudeDelta: max, longitudeDelta: max) }
        let region = MKCoordinateRegion(center: coordinate, span: span)
        self.setRegion(region, animated:true)
    }
    
    // Center Map
    open func center(location: CLLocation? = nil,
                coordinate: CLLocationCoordinate2D? = nil,
                radius: Distance! = Distance(is: 500, in: .miles),
                animated: Bool! = true) {
        guard let loc = location else {
            if let coord = coordinate {
                let locale = CLLocation(latitude: coord.latitude, longitude: coord.longitude)
                self._center(on: locale, radius: radius.meters.double, animated: animated)
            }
            return
        }
        self._center(on: loc, radius: radius.meters.double)
    }
    
    private func _center(on loc: CLLocation,
                        radius: CLLocationDistance? = 10000,
                        animated: Bool! = true) {
        let regionRadius: CLLocationDistance = radius!
        let coordinateRegion = MKCoordinateRegion(center: loc.coordinate,
                                                  latitudinalMeters: regionRadius * 2.0,
                                                  longitudinalMeters: regionRadius * 2.0)
    
        setRegion(coordinateRegion, animated: animated)
    }
    
    // MARK: Removals
    public func removeall() {
        removeAnnotations(annotations)
        removeOverlays(overlays)
    }
    
    public func removeAllAnnotes() {
        removeAnnotations(annotations)
    }
    
    public func removeAllOverlays() {
        removeOverlays(overlays)
    }
}
