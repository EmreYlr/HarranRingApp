//
//  Station.swift
//  RingApp
//
//  Created by Emre on 14.04.2024.
//

import Foundation
import MapKit

/// Station Model
class Station: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D

    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}
