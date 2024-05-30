//
//  StationViewController+TableView.swift
//  RingApp
//
//  Created by Emre on 24.05.2024.
//

import Foundation
import UIKit

extension StationViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if stationViewModel.isSearching {
            return stationViewModel.filteredStationCoordinates.count
        }
        return stationViewModel.stationCoordinate.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        let station = stationViewModel.isSearching ? stationViewModel.filteredStationCoordinates[indexPath.row] : stationViewModel.stationCoordinate[indexPath.row]
        cell.textLabel?.text = station.subtitle
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let station = stationViewModel.isSearching ? stationViewModel.filteredStationCoordinates[indexPath.row] : stationViewModel.stationCoordinate[indexPath.row]
        showAlert(title: "Detay", message: station.near!)
    }
}
