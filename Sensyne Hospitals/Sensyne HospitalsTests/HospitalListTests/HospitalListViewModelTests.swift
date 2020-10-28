//
//  HospitalListViewModelTests.swift
//  Sensyne HospitalsTests
//
//  Created by Joshua Colley on 27/10/2020.
//

import XCTest
@testable import Sensyne_Hospitals

class HospitalListViewModelTests: XCTestCase {
    
    var sut: HospitalListViewModel!
    var viewSpy: HospitalListViewSpy!
    var networkManagerSpy: NetworkManagerSpy!
    var testQueue: DispatchQueue = DispatchQueue(label: "testQueue")
    
    override func setUp() {
        self.networkManagerSpy = NetworkManagerSpy()
        self.viewSpy = HospitalListViewSpy()
        self.sut = HospitalListViewModel(view: self.viewSpy)
        sut.networkManager = self.networkManagerSpy
        sut.queue = self.testQueue
        
        super.setUp()
    }
    
    func testFetchHospitals_Success() {
        let path = Bundle(for: HospitalListViewModelTests.self).path(forResource: "Hospital", ofType: "csv") ?? ""
        let url = URL(fileURLWithPath: path)
        guard let data = try? Data(contentsOf: url) else { XCTFail("No mock data found"); return }
        self.networkManagerSpy.responseData = data
        
        sut.fetchHospitals()
        
        self.testQueue.sync {}
        XCTAssertTrue(networkManagerSpy.didCallRequest)
        XCTAssertTrue(viewSpy.didCallUpdateHospitalList)
        
        guard let hospital = self.viewSpy.hospitals?.first else {
            XCTFail("CSV to Hospital object mapping failed"); return
        }
        
        XCTAssertEqual(hospital.address1, "Unit 4")
        XCTAssertEqual(hospital.address2, "Rodney Road")
        XCTAssertEqual(hospital.address3, "Address line 3")
        XCTAssertEqual(hospital.city, "Walton-on-Thames")
        XCTAssertEqual(hospital.county, "Surrey")
        XCTAssertEqual(hospital.email, "")
        XCTAssertEqual(hospital.fax, "01932 253674")
        XCTAssertEqual(hospital.organisationCode, "NDA07")
        XCTAssertEqual(hospital.organisationId, "17970")
        XCTAssertEqual(hospital.organisationName, "Walton Community Hospital - Virgin Care Services Ltd")
        XCTAssertEqual(hospital.organisationStatus, "Visible")
        XCTAssertEqual(hospital.organisationType, "Hospital")
        XCTAssertEqual(hospital.parentName, "Virgin Care Services Ltd")
        XCTAssertEqual(hospital.parentODSCode, "NDA")
        XCTAssertEqual(hospital.phoneNumber, "01932 414205")
        XCTAssertEqual(hospital.postcode, "KT12 3LD")
        XCTAssertEqual(hospital.sector, "Independent Sector")
        XCTAssertEqual(hospital.subtype, "Hospital")
        XCTAssertEqual(hospital.website, "")
        XCTAssertEqual(hospital.isPimsManaged, false)
        XCTAssertEqual(hospital.latitude, 51.37999725341797)
        XCTAssertEqual(hospital.latitude, 51.37999725341797)
    }
    
    func testFetchHospitals_Failure() {
        self.networkManagerSpy.responseData = nil
        self.viewSpy.hospitals = nil
        
        sut.fetchHospitals()
        
        self.testQueue.sync {}
        XCTAssertTrue(networkManagerSpy.didCallRequest)
        XCTAssertFalse(viewSpy.didCallUpdateHospitalList)
        XCTAssertNil(viewSpy.hospitals)
    }
}
