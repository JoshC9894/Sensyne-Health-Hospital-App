//
//  HospitalDetailsVC.swift
//  Sensyne Hospitals
//
//  Created by Joshua Colley on 27/10/2020.
//

import UIKit

// MARK: - HospitalDetailsViewProtocol
protocol HospitalDetailsViewProtocol: class {}

// MARK: - HospitalDetailsVC
class HospitalDetailsVC: UIViewController {
    static let storyboardIdentifier: String = "HospitalDetailsVC"
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var viewModel: HospitalDetailsViewModelProtocol = { [weak self] in
        return HospitalDetailsViewModel(view: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Hospital details"
        registerCells()
    }
    
    // MARK: - Helper Methods
    private func registerCells() {
        let detailsCellNib = UINib(nibName: HospitalDetailsCell.identifier, bundle: nil)
        self.tableView.register(detailsCellNib, forCellReuseIdentifier: HospitalDetailsCell.identifier)
    }
}



// MARK: HospitalDetailsViewProtocol
extension HospitalDetailsVC: HospitalDetailsViewProtocol {
    
}
