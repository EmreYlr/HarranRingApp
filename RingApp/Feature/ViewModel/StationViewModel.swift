//
//  StationViewModel.swift
//  RingApp
//
//  Created by Emre on 24.05.2024.
//

import Foundation

protocol StationViewModelProtocol { 
    var stationCoordinate: [Station] { get }
    var filteredStationCoordinates: [Station] { get set }
    var isSearching: Bool { get set }
}

final class StationViewModel {
    var stationCoordinate: [Station] = StationCoordinate.coordinates
    var filteredStationCoordinates: [Station] = []
    var isSearching: Bool = false
}

extension StationViewModel: StationViewModelProtocol { }
