//
//  HospitalDetailsViewModel.swift
//  Sensyne Hospitals
//
//  Created by Joshua Colley on 27/10/2020.
//

import Foundation

protocol HospitalDetailsViewModelProtocol {
    var hospital: Hospital! { get set }
}

class HospitalDetailsViewModel: HospitalDetailsViewModelProtocol {
    var hospital: Hospital!
    
    weak var view: HospitalDetailsViewProtocol?
    
    init(view: HospitalDetailsViewProtocol?) {
        self.view = view
    }
}
