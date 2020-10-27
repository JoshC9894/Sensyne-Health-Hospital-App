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
}

// MARK: - HospitalListVC
class HospitalListVC: UIViewController {
    static let storyboardIdentifier: String = "HospitalListVC"
    let cellHeight: CGFloat = 85.0
    
    @IBOutlet weak var tableView: UITableView!
    
    var hospitals: [Hospital] = []
    lazy var viewModel: HospitalListViewModelProtocol = { [weak self] in
        return HospitalListViewModel(view: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCells()
        self.viewModel.fetchHospitals()
    }
    
    // MARK: - Helper Methods
    private func registerCells() {
        let identifer = HospitalListCell.identifier
        let nib = UINib(nibName: identifer, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: identifer)
    }
}

// MARK: - Implement HospitalListViewProtocol
extension HospitalListVC: HospitalListViewProtocol {
    func updateHospitalsList(_ hospitals: [Hospital]) {
        self.hospitals = hospitals
        self.tableView.reloadData()
    }
}
