//
//  tb_fbUITests.swift
//  tb_fbUITests
//
//  Created by Shveta Puri on 5/10/19.
//  Copyright © 2019 Shveta Puri. All rights reserved.
//

import XCTest

class tb_fbUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        app.navigationBars["Welcome test1@test1.com"].buttons["Add"].tap()
        app.textFields["nameTF"].tap()
        app.textFields["nameTF"].typeText("Some new value")
        app.tap()
        //app.toolbars.buttons["Done"].tap()
        app.buttons["Add Taste"].tap()
       
     
        
        
    }

}
