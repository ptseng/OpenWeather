//
//  OpenWeatherUITests.swift
//  OpenWeatherUITests
//
//  Created by Philip Tseng on 10/19/16.
//  Copyright © 2016 Phil Tseng. All rights reserved.
//

import XCTest

class OpenWeatherUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    func testNavigationBarTitle() {
        let app = XCUIApplication()
        let labels = app.staticTexts

        let navBarTitle = labels.element(boundBy: 0).label
        XCTAssertEqual(navBarTitle, "OpenWeather")
    }

    func testCityName() {
        let app = XCUIApplication()
        let labels = app.staticTexts

        let cityName = labels.element(boundBy: 1).label
        XCTAssert(!cityName.isEmpty)
    }

    func testWeatherDescription() {
        let app = XCUIApplication()
        let labels = app.staticTexts

        let weatherDescription = labels.element(boundBy: 3).label
        XCTAssert(!weatherDescription.isEmpty)
    }

    func testTemperatureUnitSelector() {
        let app = XCUIApplication()
        let labels = app.staticTexts

        let fButton = app.segmentedControls.buttons["F°"]
        let cButton = app.segmentedControls.buttons["C°"]

        let firstFTempLabel = labels.element(boundBy: 2).label
        XCTAssertEqual(fButton.isSelected, true)
        XCTAssertEqual(cButton.isSelected, false)
        cButton.tap()
        let firstCTempLabel = labels.element(boundBy: 2).label
        XCTAssertEqual(cButton.isSelected, true)
        XCTAssertEqual(fButton.isSelected, false)
        fButton.tap()
        let secondFTempLabel = labels.element(boundBy: 2).label
        XCTAssertEqual(fButton.isSelected, true)
        XCTAssertEqual(cButton.isSelected, false)

        XCTAssertEqual(firstFTempLabel, "--")
        XCTAssertNotEqual(firstFTempLabel, firstCTempLabel)
        XCTAssertNotEqual(firstCTempLabel, secondFTempLabel)
    }
}
