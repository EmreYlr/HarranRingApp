//
//  StationViewController.swift
//  RingApp
//
//  Created by Emre on 24.05.2024.
//

import UIKit

class StationViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let stationCoordinate = StationCoordinate.coordinates
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
}
