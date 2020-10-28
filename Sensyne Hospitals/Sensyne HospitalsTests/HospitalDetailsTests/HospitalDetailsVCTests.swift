//
//  HospitalDetailsVCTests.swift
//  Sensyne HospitalsTests
//
//  Created by Joshua Colley on 28/10/2020.
//

import XCTest
@testable import Sensyne_Hospitals

class HospitalDetailsVCTests: XCTestCase {
    
    var sut: HospitalDetailsVC!
    var viewModelSpy: HospitalDetailsViewModelSpy!
    var window: UIWindow!
    
    override func setUp() {
        self.window = UIWindow()
        
        let sutIdentifier = HospitalDetailsVC.storyboardIdentifier
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: sutIdentifier) as? HospitalDetailsVC else {
            fatalError();
        }
        
        self.viewModelSpy = HospitalDetailsViewModelSpy()
        self.sut = vc
        self.sut.viewModel = self.viewModelSpy
        
        super.setUp()
    }
    
    func testViewDidLoad_DetailsCell() {
        self.viewModelSpy.hospital = self.mockHospital()
        
        self.window.addSubview(self.sut.view)
        
        let row = HospitalDetailSections.details
        let indexPath = IndexPath(row: row.rawValue, section: 0)
        guard let cell = sut.tableView.cellForRow(at: indexPath) as? HospitalDetailsCell else {
            XCTFail("Failed to cast cell"); return
        }
        
        XCTAssertEqual(cell.organisationNameLabel.text, "Test Hospital")
        XCTAssertEqual(cell.organisationTypeLabel.text, "Hospital")
    }
    
    func testViewDidLoad_LocationCell() {
        self.viewModelSpy.hospital = self.mockHospital()
        
        self.window.addSubview(self.sut.view)
        
        let row = HospitalDetailSections.location
        let indexPath = IndexPath(row: row.rawValue, section: 0)
        guard let cell = sut.tableView.cellForRow(at: indexPath) as? HospitalLocationCell else {
            XCTFail("Failed to cast cell"); return
        }
        
        XCTAssertEqual(cell.addressLabel.text, "Address 1, Address 2, Address 3, City, County, Postcode")
        XCTAssertEqual(cell.mapView.centerCoordinate.latitude, 0.023000000000024556)
        XCTAssertEqual(cell.mapView.centerCoordinate.longitude, 1.0560000000000969)
    }
    
    func testViewDidLoad_ContactCell() {
        self.viewModelSpy.hospital = self.mockHospital()

        self.window.addSubview(self.sut.view)
        
        let row = HospitalDetailSections.contact
        let indexPath = IndexPath(row: row.rawValue, section: 0)
        guard let cell = sut.tableView.cellForRow(at: indexPath) as? HospitalContactCell else {
            XCTFail("Failed to cast cell"); return
        }
        
        XCTAssertEqual(cell.phoneLabel.text, "0123456789")
        XCTAssertEqual(cell.emailLabel.text, "email@address.com")
        XCTAssertEqual(cell.websiteLabel.text, "https://test.com")
    }
    
    // MARK: - Private Methods
    private func mockHospital() -> Hospital {
        var hospital = Hospital()
        hospital.organisationName = "Test Hospital"
        hospital.organisationType = "Hospital"
        hospital.address1 = "Address 1"
        hospital.address2 = "Address 2"
        hospital.address3 = "Address 3"
        hospital.postcode = "Postcode"
        hospital.city = "City"
        hospital.county = "County"
        hospital.latitude = 0.023000000000024556
        hospital.longitude = 1.0560000000000969
        hospital.phoneNumber = "0123456789"
        hospital.email = "email@address.com"
        hospital.website = "https://test.com"
        return hospital
    }
}
