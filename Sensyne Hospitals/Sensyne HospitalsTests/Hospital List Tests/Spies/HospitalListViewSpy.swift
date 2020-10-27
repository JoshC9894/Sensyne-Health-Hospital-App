//
//  HospitalListViewSpy.swift
//  Sensyne HospitalsTests
//
//  Created by Joshua Colley on 27/10/2020.
//
@testable import Sensyne_Hospitals

class HospitalListViewSpy: HospitalListViewProtocol {
    var didCallUpdateHospitalList: Bool = false
    var hospitals: [Hospital]?
    
    func updateHospitalsList(_ hospitals: [Hospital]) {
        self.didCallUpdateHospitalList = true
        self.hospitals = hospitals
    }
}
