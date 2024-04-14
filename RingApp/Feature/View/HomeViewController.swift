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

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        homeViewModel.delegate = self
        initScreen()
    }

    func initScreen() {
        homeViewModel.getMapStartView(mapView: mapView)
        homeViewModel.getStations(mapView: mapView)
        homeViewModel.getRoute(mapView: mapView)
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
