//
//  HospitalListViewModel.swift
//  Sensyne Hospitals
//
//  Created by Joshua Colley on 26/10/2020.
//

// MARK: - HospitalListViewModelProtocol
protocol HospitalListViewModelProtocol {
}

// MARK: - HospitalListViewModel
class HospitalListViewModel: HospitalListViewModelProtocol {
    weak var view: HospitalListViewProtocol?
    
    init(view: HospitalListViewProtocol) {
        self.view = view
    }
}
