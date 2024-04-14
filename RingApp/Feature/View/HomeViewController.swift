//
//  ViewController.swift
//  RingApp
//
//  Created by Emre on 10.04.2024.
//

import UIKit
import MapKit

class HomeViewController: UIViewController {
    
    // MARK: -Variables
    @IBOutlet weak var mapView: MKMapView!
    
    var homeViewModel: HomeViewModelProtocol = HomeViewModel()
    let location = CLLocation(latitude: 37.1725812, longitude: 38.996985)
    let maxZoomLevel: CLLocationDistance = 1700
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        homeViewModel.delegate = self
        initScreen()
    }

    func initScreen() {
        initMapView()
        homeViewModel.getStations(mapView: mapView)
    }
    
    func initMapView(){
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: maxZoomLevel, longitudinalMeters: maxZoomLevel)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}

//MARK: -HomeViewModelOutputProtocol
extension HomeViewController: HomeViewModelOutputProtocol {
    func update() {
        print("Update")
    }
    
    func error() {
        print("Error")
    }
}
