//
//  HomeViewMapView.swift
//  RingApp
//
//  Created by Emre on 12.04.2024.
//

import Foundation
import MapKit

// MARK: - MKMapViewDelegate
extension HomeViewController: MKMapViewDelegate {
    //MAP kitleme işlemi
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        let currentRegion = mapView.region
        let distanceFromCenter = CLLocation(latitude: currentRegion.center.latitude, longitude: currentRegion.center.longitude).distance(from: location)
        if distanceFromCenter > maxZoomLevel {
            let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: maxZoomLevel, longitudinalMeters: maxZoomLevel)
            mapView.setRegion(coordinateRegion, animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        } else {
            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "Annotation")
            annotationView.image = UIImage(systemName: "mappin.circle")
            annotationView.canShowCallout = true
            return annotationView
        }
        
    }
}




