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
    
    lazy var viewModel: HospitalDetailsViewModelProtocol = { [weak self] in
        return HospitalDetailsViewModel(view: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.viewModel.hospital.organisationName
    }
}



// MARK: HospitalDetailsViewProtocol
extension HospitalDetailsVC: HospitalDetailsViewProtocol {
    
}
