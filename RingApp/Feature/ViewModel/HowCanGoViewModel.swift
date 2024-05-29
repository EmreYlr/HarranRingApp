//
//  HowCanGoViewModel.swift
//  RingApp
//
//  Created by Emre on 29.05.2024.
//

import Foundation
import MapKit

protocol HowCanGoViewModelProtocol {
    var stations: [Station] { get }
    func getMapStartView(mapView: MKMapView)
    func getStations(mapView: MKMapView)
    func getRoute(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D, mapView: MKMapView)
    func zoomToFitMapAnnotations(mapView: MKMapView, from: CLLocationCoordinate2D, to: CLLocationCoordinate2D)
    func findNearestStation(userLocation: CLLocationCoordinate2D) -> Station?
    
}

final class HowCanGoViewModel {
    private(set) var stations: [Station] = []
    
    func getMapStartView(mapView: MKMapView) {
        let coordinateRegion = MKCoordinateRegion(center: InitLocationCoordinate.location.coordinate, latitudinalMeters: InitLocationCoordinate.maxZoomLevel, longitudinalMeters: InitLocationCoordinate.maxZoomLevel)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func getStations(mapView: MKMapView) {
        let coordinates = StationCoordinate.coordinates
        for (index,_) in coordinates.enumerated(){
            stations.append(coordinates[index])
        }
        mapView.addAnnotations(stations)
    }
    
    func getRoute(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D, mapView: MKMapView) {
        var coordinates: [CLLocationCoordinate2D] = []
        coordinates.append(from)
        coordinates.append(to)
        let polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
        mapView.addOverlay(polyline)
    }
    
    func zoomToFitMapAnnotations(mapView: MKMapView, from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) {
        var regionRect = MKMapRect.null
        let fromPoint = MKMapPoint(from)
        let toPoint = MKMapPoint(to)
        
        let mapPoints = [fromPoint, toPoint]
        
        for point in mapPoints {
            let pointRect = MKMapRect(x: point.x, y: point.y, width: 0.1, height: 0.1)
            regionRect = regionRect.union(pointRect)
        }
        
        let edgePadding = UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
        mapView.setVisibleMapRect(regionRect, edgePadding: edgePadding, animated: true)
    }
    
    private func haversineDistance(lat1: Double, lon1: Double, lat2: Double, lon2: Double) -> Double {
        let R = 6371000.0 // Dünya'nın yarıçapı (metre)
        let φ1 = lat1 * .pi / 180
        let φ2 = lat2 * .pi / 180
        let Δφ = (lat2 - lat1) * .pi / 180
        let Δλ = (lon2 - lon1) * .pi / 180

        let a = sin(Δφ / 2) * sin(Δφ / 2) +
                cos(φ1) * cos(φ2) *
                sin(Δλ / 2) * sin(Δλ / 2)
        let c = 2 * atan2(sqrt(a), sqrt(1 - a))

        return R * c
    }

    func findNearestStation(userLocation: CLLocationCoordinate2D) -> Station? {
        var nearestStation: Station?
        var shortestDistance = Double.greatestFiniteMagnitude

        for station in StationCoordinate.coordinates {
            let distance = haversineDistance(
                lat1: userLocation.latitude,
                lon1: userLocation.longitude,
                lat2: station.coordinate.latitude,
                lon2: station.coordinate.longitude
            )
            if distance < shortestDistance {
                shortestDistance = distance
                nearestStation = station
            }
        }
        return nearestStation
    }

    
    
}

extension HowCanGoViewModel: HowCanGoViewModelProtocol { }
