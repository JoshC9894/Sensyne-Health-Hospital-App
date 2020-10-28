//
//  HospitalListViewModelSpy.swift
//  Sensyne HospitalsTests
//
//  Created by Joshua Colley on 27/10/2020.
//
import UIKit
@testable import Sensyne_Hospitals

class HospitalListViewModelSpy: HospitalListViewModelProtocol {
    
    var didCallFetchHospitals: Bool = false
    
    var searchBarPlaceholderText: NSAttributedString = NSAttributedString(string: "Search placeholder")
    func fetchHospitals() { self.didCallFetchHospitals = true }
    func filterHospitals(by query: String) {}
    func didTapFilterButton() {}
}

