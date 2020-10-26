//
//  HospitalListVC.swift
//  Sensyne Hospitals
//
//  Created by Joshua Colley on 26/10/2020.
//

import UIKit

// MARK: - HospitalListViewProtocol
protocol HospitalListViewProtocol: class {}

// MARK: - HospitalListVC
class HospitalListVC: UIViewController {
    lazy var viewModel: HospitalListViewModelProtocol = { [weak self] in
        return HospitalListViewModel(view: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.fetchHospitals()
    }
}

// MARK: - Implement HospitalListViewProtocol
extension HospitalListVC: HospitalListViewProtocol {
    
}
