//
//  HowCanGoViewController+LocationManager.swift
//  RingApp
//
//  Created by Emre on 29.05.2024.
//

import Foundation
import CoreLocation
import MapKit

extension HowCanGoViewController: CLLocationManagerDelegate {
    
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
        userLocation = location.coordinate
        if let userLocation = userLocation {
            nearestStation = howCanGoViewModel.findNearestStation(userLocation: userLocation)
            stationLabel.text = "\(nearestStation?.title ?? "YOK") - \(nearestStation?.subtitle ?? "YOK")"
        }
        
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error)")
    }
}
