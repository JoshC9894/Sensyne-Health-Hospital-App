//
//  HospitalListVCTests.swift
//  Sensyne HospitalsTests
//
//  Created by Joshua Colley on 27/10/2020.
//

import XCTest
@testable import Sensyne_Hospitals

class HospitalListVCTests: XCTestCase {
    
    var sut: HospitalListVC!
    var viewModelSpy: HospitalListViewModelSpy!
    var window: UIWindow!
    
    override func setUp() {
        self.window = UIWindow()
        
        let sutIdentifier = HospitalListVC.
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: sutIdentifier) as? HospitalListVC else {
            fatalError();
        }
        
        self.viewModelSpy = HospitalListViewModelSpy()
        self.sut = vc
        self.sut.viewModel = self.viewModelSpy
        
        super.setUp()
    }
    
    func testViewDidLoad() {
        self.window.addSubview(self.sut.view)
        XCTAssertTrue(self.viewModelSpy.didCallFetchHospitals)
    }
    
    func testUpdateHospitalsList() {
        let organisationName = "Test Hospital Name"
        let organisationType = "Hospital"
        
        self.window.addSubview(self.sut.view)
        var hospital = Hospital()
        hospital.organisationName = organisationName
        hospital.organisationType = organisationType
        
        sut.updateHospitalsList([hospital])
        
        let indexPath = IndexPath(row: 0, section: 0)
        guard let cell = sut.tableView.cellForRow(at: indexPath) as? HospitalListCell else {
            XCTFail("Failed to cast cell"); return
        }
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(cell.orgNameLabel.text, organisationName)
        XCTAssertEqual(cell.orgTypeLabel.text, organisationType)
    }
}
