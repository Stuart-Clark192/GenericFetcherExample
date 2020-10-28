//
//  GenericFetcherExampleUITests.swift
//  GenericFetcherExampleUITests
//
//  Created by Stuart on 24/10/2020.
//

import XCTest

class GenericFetcherExampleUITests: XCTestCase {

    func testExample() throws {
        // UI tests must launch the application that they test.
        
        let app = XCUIApplication()
        app.launchArguments = ["UITestMode"]
        app.launch()

        let expectedValue = app.tables.buttons["Leanne Graham"]
    
        //Used to print the view hierarchy
        //print(app.debugDescription)
        
        _ = expectedValue.waitForExistence(timeout: 5)
        XCTAssertTrue(expectedValue.exists)
    }
}
