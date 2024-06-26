//
//  HomeViewController+LocationManager.swift
//  RingApp
//
//  Created by Emre on 14.04.2024.
//

import Foundation
import CoreLocation
import MapKit

extension HomeViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                self?.startUpdatingLocation()
            }
        } else {
            showAlert(title: "Error", message: "Konum izni verilmedi!")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        lat = location.coordinate.latitude
        long = location.coordinate.longitude
//        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        showAlert(title: "Error", message: "Location manager failed with error: \(error)")
    }
}
