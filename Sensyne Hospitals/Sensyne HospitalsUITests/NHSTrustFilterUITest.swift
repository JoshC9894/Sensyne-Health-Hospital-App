//
//  NHSTrustFilterUITest.swift
//  Sensyne HospitalsUITests
//
//  Created by Joshua Colley on 28/10/2020.
//

import XCTest
@testable import Sensyne_Hospitals

class NHSTrustFilterUITest: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        app.launch()
        continueAfterFailure = true
    }

    func testNHSTrustFilter() throws {
        
        let nonNHSCell_One = app.tables/*@START_MENU_TOKEN@*/.cells.staticTexts["01932 414205"]/*[[".cells.staticTexts[\"01932 414205\"]",".staticTexts[\"01932 414205\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
        XCTAssertTrue(nonNHSCell_One.exists)
        
        let filterButton = app.navigationBars["Hospitals"].children(matching: .button).element
        XCTAssertTrue(filterButton.exists)
        
        filterButton.tap()
        
        let actionsheet = app.sheets["Filters"]
        XCTAssertTrue(actionsheet.exists)
        
        let nhsFilterOption = actionsheet.scrollViews.otherElements.buttons["Only NHS trusts"]
        XCTAssertTrue(nhsFilterOption.exists)
        
        nhsFilterOption.tap()
        
        let nonNHSCell_Two = app.tables/*@START_MENU_TOKEN@*/.cells.staticTexts["01932 414205"]/*[[".cells.staticTexts[\"01932 414205\"]",".staticTexts[\"01932 414205\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
        XCTAssertFalse(nonNHSCell_Two.exists)
    }
}
