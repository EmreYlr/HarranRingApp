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
        return stationCoordinate.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = stationCoordinate[indexPath.row].subtitle
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showAlert(title: "Detay", message: stationCoordinate[indexPath.row].near!)
    }
}
