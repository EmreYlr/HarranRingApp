//
//  StationViewController+SearchView.swift
//  RingApp
//
//  Created by Emre on 30.05.2024.
//

import Foundation
import UIKit

extension StationViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            stationViewModel.isSearching = false
            stationViewModel.filteredStationCoordinates.removeAll()
        } else {
            stationViewModel.isSearching = true
            let lowercasedSearchText = searchText.lowercased()
            stationViewModel.filteredStationCoordinates = stationViewModel.stationCoordinate.filter {
                $0.near?.lowercased().contains(lowercasedSearchText) ?? false}
        }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        stationViewModel.isSearching = false
        searchBar.text = ""
        stationViewModel.filteredStationCoordinates.removeAll()
        tableView.reloadData()
    }
}
