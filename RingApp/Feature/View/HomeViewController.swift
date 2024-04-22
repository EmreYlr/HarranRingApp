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
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    var homeViewModel: HomeViewModelProtocol = HomeViewModel()
    var locationManager = CLLocationManager()
    var lat, long: Double?
    
    //MARK: -FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        homeViewModel.delegate = self
        initScreen()
                
    }
    
    @IBAction func startButtonAction(_ sender: UIButton) {
        let status = locationManager.authorizationStatus
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            startUpdatingLocation()
            let uuid = UIDevice.current.identifierForVendor?.uuidString
            print(uuid ?? "")
            let userLocation = UserLocation(latitude: lat ?? 0.00, longitude: long ?? 0.00, deviceId: uuid ?? "")
//            DispatchQueue.main.async {
//                self.homeViewModel.postBus(userParams: userLocation)
//            }
            print(userLocation)
        } else {
            print("Konum izni verilmedi")
        }
        
    }
    
    func initScreen() {
        homeViewModel.fetchBus()
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
        print(homeViewModel.bus)
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
