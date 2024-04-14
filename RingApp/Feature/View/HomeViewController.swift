//
//  ViewController.swift
//  RingApp
//
//  Created by Emre on 10.04.2024.
//

import UIKit
import MapKit
import CoreLocation

class HomeViewController: UIViewController {
    
    // MARK: -VARIABLES
    @IBOutlet weak var mapView: MKMapView!
    var homeViewModel: HomeViewModelProtocol = HomeViewModel()
    var locationManager = CLLocationManager()
    
    //MARK: -FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        homeViewModel.delegate = self
        initScreen()
        
    }
    
    func initScreen() {
        homeViewModel.getMapStartView(mapView: mapView)
        homeViewModel.getStations(mapView: mapView)
        homeViewModel.getRoute(mapView: mapView)
        homeViewModel.checkLocationAuthorization(locationManager: locationManager)
    }
    
}

//MARK: -HomeViewModelOutputProtocol
extension HomeViewController: HomeViewModelOutputProtocol {
    func update() {
        self.startUpdatingLocation()
        print("Update")
    }
    
    func error() {
        print("Error")
    }
}

//MARK: -Current Location
extension HomeViewController {
    func startUpdatingLocation() {
        DispatchQueue.main.async { [weak self] in
            self?.mapView.showsUserLocation = true
        }
        locationManager.startUpdatingLocation()
    }
}
