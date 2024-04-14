//
//  HomeViewModel.swift
//  RingApp
//
//  Created by Emre on 12.04.2024.
//

import Foundation
import MapKit

protocol HomeViewModelProtocol {
    var delegate: HomeViewModelOutputProtocol? { get set }
    var stations: [Station] { get }
    var bus: [Bus] { get }
    func getStations(mapView: MKMapView)
    func getMapStartView(mapView: MKMapView)
    func getRoute(mapView: MKMapView)
}

protocol HomeViewModelOutputProtocol: AnyObject{
    func update()
    func error()
}

class HomeViewModel {
    weak var delegate: HomeViewModelOutputProtocol?
    private(set) var stations: [Station] = []
    private(set) var bus: [Bus] = []
    
    func getStations(mapView: MKMapView) {
        let coordinates = StationCoordinate.coordinates
        for (index,_) in coordinates.enumerated(){
            stations.append(coordinates[index])
        }
        if stations.isEmpty {
            delegate?.error()
        } else {
            mapView.addAnnotations(stations)
            delegate?.update()
        }
    }
    
    func getMapStartView(mapView: MKMapView) {
        let coordinateRegion = MKCoordinateRegion(center: InitLocationCoordinate.location.coordinate, latitudinalMeters: InitLocationCoordinate.maxZoomLevel, longitudinalMeters: InitLocationCoordinate.maxZoomLevel)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func getRoute(mapView: MKMapView) {
        let coordinates = RouteCoordinate.coordinates
        let polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
        mapView.addOverlay(polyline)
    }
}

extension HomeViewModel: HomeViewModelProtocol {}
