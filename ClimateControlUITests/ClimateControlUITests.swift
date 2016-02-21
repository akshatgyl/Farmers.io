

//
//  ClimateControlUITests.swift
//  ClimateControlUITests
//
//  Created by Akshat Goyal on 2/20/16.
//  Copyright © 2016 akshat. All rights reserved.
//

import XCTest
import LoginWithClimate


class ClimateControlUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        app.otherElements.containingType(.Image, identifier:"farmers.io").childrenMatchingType(.Button).element.tap()
        
        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        emailTextField.typeText("adityadhingra07@gmail.com")
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("Akshat1122\r")
        
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Test_field3"].tap()
        tablesQuery.cells.containingType(.StaticText, identifier:"Test_Field5").childrenMatchingType(.StaticText).matchingIdentifier("Test_Field5").elementBoundByIndex(0).tap()
        tablesQuery.cells.containingType(.StaticText, identifier:"Test_field1").childrenMatchingType(.StaticText).matchingIdentifier("Test_field1").elementBoundByIndex(0).tap()
        
    }
    
}
