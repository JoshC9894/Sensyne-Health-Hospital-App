//
//  HospitalListVC.swift
//  Sensyne Hospitals
//
//  Created by Joshua Colley on 26/10/2020.
//

import UIKit

// MARK: - HospitalListViewProtocol
protocol HospitalListViewProtocol: class {
    func updateHospitalsList(_ hospitals: [Hospital])
    func presentFilters(_ actionSheet: UIAlertController)
}

// MARK: - HospitalListVC
class HospitalListVC: UIViewController {
    static let storyboardIdentifier: String = "HospitalListVC"
    let cellHeight: CGFloat = UITableView.automaticDimension
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterButton: UIBarButtonItem!
    
    var hospitals: [Hospital] = []
    lazy var viewModel: HospitalListViewModelProtocol = { [weak self] in
        return HospitalListViewModel(view: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCells()
        self.setupNavbar()
        self.viewModel.fetchHospitals()
    }
    
    // MARK: - Helper Methods
    private func registerCells() {
        let identifer = HospitalListCell.identifier
        let nib = UINib(nibName: identifer, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: identifer)
    }
    
    private func setupNavbar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.searchTextField.attributedPlaceholder = self.viewModel.searchBarPlaceholderText
        searchController.searchBar.searchTextField.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        searchController.searchBar.searchTextField.textColor = UIColor.white
        searchController.searchBar.searchTextField.leftView?.tintColor = .white
        searchController.searchBar.searchTextField.rightView?.tintColor = .white
        navigationItem.searchController = searchController
    }
    
    @IBAction func filterButtonSelector(_ sender: UIBarButtonItem) {
        self.viewModel.didTapFilterButton()
    }
}

// MARK: - Implement HospitalListViewProtocol
extension HospitalListVC: HospitalListViewProtocol {
    func updateHospitalsList(_ hospitals: [Hospital]) {
        self.hospitals = hospitals
        self.tableView.reloadData()
    }
    
    func presentFilters(_ actionSheet: UIAlertController) {
        self.present(actionSheet, animated: true, completion: nil)
    }
}

// MARK: - UISearchResultsUpdating
extension HospitalListVC: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    if let query = searchBar.text {
        self.viewModel.filterHospitals(by: query)
    }
  }
}
