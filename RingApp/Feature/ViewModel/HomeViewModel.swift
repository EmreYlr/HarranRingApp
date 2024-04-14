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
    func getStations(mapView: MKMapView)
}

protocol HomeViewModelOutputProtocol: AnyObject{
    func update()
    func error()
}

class HomeViewModel {
    weak var delegate: HomeViewModelOutputProtocol?
    private(set) var stations: [Station] = []
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
}

extension HomeViewModel: HomeViewModelProtocol {}
