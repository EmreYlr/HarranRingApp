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
    var bus: [Bus] { get set }
    func fetchBus()
    func postBus(userParams: UserLocation)
    func getBus(mapView: MKMapView)
    func getStations(mapView: MKMapView)
    func getMapStartView(mapView: MKMapView)
    func getRoute(mapView: MKMapView)
    func checkLocationAuthorization(locationManager: CLLocationManager)
}

protocol HomeViewModelOutputProtocol: AnyObject{
    func update()
    func stopLoad()
    func error()
    func postUpdate()
    func postError()
}

final class HomeViewModel {
    weak var delegate: HomeViewModelOutputProtocol?
    private(set) var stations: [Station] = []
    var bus: [Bus] = []
    
    func fetchBus() {
        if let url = URL(string: BusPath.GETLASTLOCATION.fullPath()) {
            DispatchQueue.main.async {
                NetworkManager.shared.request(from: url, method: .get) { [weak self] (result: Result<[Bus], ErrorTypes>) in
                    switch result {
                    case .success(let data):
                        self?.bus = data
                        self?.delegate?.update()
                    case .failure(_):
                        //print("Hata: \(error)")
                        self?.delegate?.error()
                    }
                    self?.delegate?.stopLoad()
                }
            }
        }
    }
    
    func postBus(userParams: UserLocation) {
        let params: [String : Any] = [
            "latitude": userParams.latitude,
            "longitude": userParams.longitude,
            "deviceId": userParams.deviceId]
        
        if let url = URL(string: BusPath.POSTLOCATION.fullPath()) {
            NetworkManager.shared.requestDecodable(from: url, method: .post, parameters: params) { [weak self] (result: Result<Void, ErrorTypes>) in
                switch result {
                case .success(_):
                    //print("Başarılı")
                    self?.delegate?.postUpdate()
                    break
                case .failure(_):
                    //print("Hata: \(error)")
                    self?.delegate?.postError()
                }
            }
        }
        
    }
    
    func getBus(mapView: MKMapView){
        for bus in bus {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: bus.latitude, longitude: bus.longitude)
            annotation.title = "Paylaşan Sayısı: \(bus.count)"
            mapView.addAnnotation(annotation)
        }
    }
    
    func getStations(mapView: MKMapView) {
        let coordinates = StationCoordinate.coordinates
        for (index,_) in coordinates.enumerated(){
            stations.append(coordinates[index])
        }
        mapView.addAnnotations(stations)
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
    
    func checkLocationAuthorization(locationManager: CLLocationManager) {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            DispatchQueue.global(qos: .userInitiated).async {
                self.delegate?.update()
            }
        case .denied, .restricted:
            print("Konum izni vermediniz")
            self.delegate?.error()
            break
        @unknown default:
            break
        }
    }
}

extension HomeViewModel: HomeViewModelProtocol {}
