//
//  HowCanGoViewController+MapView.swift
//  RingApp
//
//  Created by Emre on 29.05.2024.
//

import Foundation
import MapKit

extension HowCanGoViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        let currentRegion = mapView.region
        let distanceFromCenter = CLLocation(latitude: currentRegion.center.latitude, longitude: currentRegion.center.longitude).distance(from: InitLocationCoordinate.location)
        if distanceFromCenter > InitLocationCoordinate.maxZoomLevel {
            let coordinateRegion = MKCoordinateRegion(center: InitLocationCoordinate.location.coordinate, latitudinalMeters: InitLocationCoordinate.maxZoomLevel, longitudinalMeters: InitLocationCoordinate.maxZoomLevel)
            mapView.setRegion(coordinateRegion, animated: true)
        }
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        } 
        else {
            let busStopAnnotation = annotation
            let identifier = "BusStopAnnotation"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: busStopAnnotation, reuseIdentifier: identifier)
                annotationView?.image = UIImage(systemName: "mappin.circle")
                annotationView?.canShowCallout = true
            } else {
                annotationView?.annotation = busStopAnnotation
            }
            return annotationView
        }
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = UIColor.green
            renderer.lineWidth = 5.0
            renderer.alpha = 0.5
            return renderer
        }
        return MKOverlayRenderer()
    }
}
