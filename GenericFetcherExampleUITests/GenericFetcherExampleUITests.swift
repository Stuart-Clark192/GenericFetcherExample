//
//  GenericFetcherExampleUITests.swift
//  GenericFetcherExampleUITests
//
//  Created by Stuart on 24/10/2020.
//

import XCTest

class GenericFetcherExampleUITests: XCTestCase {

    private var session: URLSession!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        
        let app = XCUIApplication()
        app.launchArguments = ["UITestMode"]
        app.launch()

        let expectedValue = XCUIApplication().tables.staticTexts["Leanne Graham"]
        _ = expectedValue.waitForExistence(timeout: 5)
        XCTAssertTrue(expectedValue.exists)
    }
}