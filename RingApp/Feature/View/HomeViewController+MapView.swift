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
        let distanceFromCenter = CLLocation(latitude: currentRegion.center.latitude, longitude: currentRegion.center.longitude).distance(from: InitLocationCoordinate.location)
        if distanceFromCenter > InitLocationCoordinate.maxZoomLevel {
            let coordinateRegion = MKCoordinateRegion(center: InitLocationCoordinate.location.coordinate, latitudinalMeters: InitLocationCoordinate.maxZoomLevel, longitudinalMeters: InitLocationCoordinate.maxZoomLevel)
            mapView.setRegion(coordinateRegion, animated: true)
        }
    }
    //Annotation işlemi
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
    //Rotayı çizme işlemi
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = UIColor.blue
            renderer.lineWidth = 5.0
            renderer.alpha = 0.5
            return renderer
        }
        return MKOverlayRenderer()
    }
    
}
