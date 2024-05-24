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
    @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
    @IBOutlet weak var locationStateLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var stopButton: UIButton!
    var homeViewModel: HomeViewModelProtocol = HomeViewModel()
    var locationManager = CLLocationManager()
    var lat, long: Double?
    var mapViewReloadTimer: Timer?
    var locationShareReloadTimer: Timer?
    
    //MARK: -FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        homeViewModel.delegate = self
        startButton.layer.cornerRadius = 10
        stopButton.layer.cornerRadius = 10
        initScreen()
    }
    @objc func updateData() {
        homeViewModel.bus.removeAll()
        mapView.removeAnnotations(mapView.annotations)
        homeViewModel.fetchBus()
        homeViewModel.getStations(mapView: mapView)
    }
    
    @IBAction func stopButtonAction(_ sender: Any) {
        locationShareTimerStop()
        locationManager.stopUpdatingLocation()
        startButton.isEnabled = true
        stopButton.isEnabled = false
        locationStateLabel.text = "PASİF"
        locationStateLabel.textColor = .red
    }
    
    @IBAction func startButtonAction(_ sender: UIButton) {
        let status = locationManager.authorizationStatus
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            startUpdatingLocation()
            locationShareTimerStart()
            startButton.isEnabled = false
            stopButton.isEnabled = true
            locationStateLabel.text = "AKTİF"
            locationStateLabel.textColor = .green
        } else {
            print("Konum izni verilmedi")
        }
        mapViewTimerStart()
    }
    
    func initScreen() {
        mapView.isHidden = true
        homeViewModel.fetchBus()
        homeViewModel.getMapStartView(mapView: mapView)
        homeViewModel.getStations(mapView: mapView)
        homeViewModel.getRoute(mapView: mapView)
        homeViewModel.checkLocationAuthorization(locationManager: locationManager)
    }
    
    func mapViewTimerStop() {
        mapViewReloadTimer?.invalidate()
        mapViewReloadTimer = nil
    }
    
    func mapViewTimerStart() {
        mapViewReloadTimer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(updateData), userInfo: nil, repeats: true)
    }
    
    func locationShareTimerStop() {
        locationShareReloadTimer?.invalidate()
        locationShareReloadTimer = nil
    }
    
    func locationShareTimerStart() {
        locationShareReloadTimer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(startLocationShare), userInfo: nil, repeats: true)
    }
    
    @objc func startLocationShare() {
        let uuid = UIDevice.current.identifierForVendor?.uuidString
        print(uuid ?? "")
        let userLocation = UserLocation(latitude: lat ?? 0.00, longitude: long ?? 0.00, deviceId: uuid ?? "")
        DispatchQueue.main.async {
            self.homeViewModel.postBus(userParams: userLocation)
        }
    }
    
}

//MARK: -HomeViewModelOutputProtocol
extension HomeViewController: HomeViewModelOutputProtocol {
    
    func stopLoad() {
        mapView.isHidden = false
        loadIndicator.isHidden = true
        loadIndicator.stopAnimating()
    }
    
    func update() {
        self.startUpdatingLocation()
        homeViewModel.getBus(mapView: mapView)
        print("Update")
    }
    
    func error() {
        showAlert(title: "Hata Mesajı", message: "İnternet bağlantınızda hata oluştu. Lütfen bağlantınızı kontrol edip tekrar deneyiniz.")
        mapViewTimerStop()
        locationShareTimerStop()
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
