//
//  HowCanGoViewController.swift
//  RingApp
//
//  Created by Emre on 29.05.2024.
//

import UIKit
import MapKit

class HowCanGoViewController: UIViewController {
    //MARK: -VARIABLES
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var stationLabel: UILabel!
    @IBOutlet weak var goButton: UIButton!
    
    var locationManager = CLLocationManager()
    var userLocation: CLLocationCoordinate2D?
    var nearestStation: Station?
    var howCanGoViewModel: HowCanGoViewModelProtocol = HowCanGoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLoad()
    }
    
    func initLoad() {
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        startUpdatingLocation()
        goButton.layer.cornerRadius = 10
        stationLabel.layer.cornerRadius = 10
        stationLabel.layer.masksToBounds = true
        howCanGoViewModel.getMapStartView(mapView: mapView)
        howCanGoViewModel.getStations(mapView: mapView)
    }
    
    @IBAction func goButtonAction(_ sender: Any) {
        if let userLocation = userLocation, let nearestStation = nearestStation {
            mapView.removeOverlays(mapView.overlays)
            howCanGoViewModel.getRoute(from: userLocation, to: nearestStation.coordinate, mapView: mapView)
            howCanGoViewModel.zoomToFitMapAnnotations(mapView: mapView, from: userLocation, to: nearestStation.coordinate)
        }
    }

    func startUpdatingLocation() {
        DispatchQueue.main.async { [weak self] in
            self?.mapView.showsUserLocation = true
        }
        locationManager.startUpdatingLocation()
        
    }
}
