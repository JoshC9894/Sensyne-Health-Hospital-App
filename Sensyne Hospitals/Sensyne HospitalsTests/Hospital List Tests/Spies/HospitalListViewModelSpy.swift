//
//  HospitalListViewModelSpy.swift
//  Sensyne HospitalsTests
//
//  Created by Joshua Colley on 27/10/2020.
//
@testable import Sensyne_Hospitals

class HospitalListViewModelSpy: HospitalListViewModelProtocol {
    var didCallFetchHospitals: Bool = false
    
    func fetchHospitals() {
        self.didCallFetchHospitals = true
    }
}

