//
//  StationViewController.swift
//  RingApp
//
//  Created by Emre on 24.05.2024.
//

import UIKit

class StationViewController: UIViewController {
    //MARK: -VARIABLES
    @IBOutlet weak var tableView: UITableView!
    let searchBar = UISearchBar()
    var stationViewModel: StationViewModelProtocol = StationViewModel()
    
    //MARK: -Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        initLoad()
        setupSearchBar()
    }
    
    func initLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }
    
    func setupSearchBar() {
        searchBar.sizeToFit()
        searchBar.placeholder = "Arama"
        tableView.tableHeaderView = searchBar
    }
}
