//
//  MapManager.swift
//  LocationProject
//
//  Created by 박성훈 on 9/10/25.
//

import Foundation
import MapKit

final class MapViewHepler {
    private weak var mapView: MKMapView?
    
    init(mapView: MKMapView) {
        self.mapView = mapView
    }
    
    func setRegion(lat: Double, lon: Double) {
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        
        addPin(coordinate: coordinate)
        
        mapView?.setRegion(region, animated: true)
    }
    
    private func addPin(coordinate: CLLocationCoordinate2D) {
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        mapView?.addAnnotation(pin)
    }
    
}
