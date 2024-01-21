//
//  DIPAssignmentUITests.swift
//  DIPAssignmentUITests
//
//  Created by Tejas Patelia on 15/06/21.
//

import XCTest

class DIPAssignmentUITests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    private func launchApp() -> XCUIApplication {
        let app = XCUIApplication()
        app.launch()
        return app
    }
    func testGivenOpeningView_TestsIsEmptyOrNot() throws {
        _ = launchApp()
        XCTAssertTrue(isViewNotEmpty)
    }
    
    var isViewNotEmpty: Bool {
        let app = launchApp()
        let table = app.tables[AccessibilityIdentifier.tableView.rawValue]
            .waitForExistence(timeout: 1)
        let switches = app.switches[AccessibilityIdentifier.switches.rawValue]
            .waitForExistence(timeout: 1)
        return table && switches
    }
    
    func testsScrollTableView() {
        let app = launchApp()
        let cell = app.getTableCell(at: 14)
        app.scrollTo(element: cell)
        cell.tap()
        //XCTAssertTrue(isDetailScreenDrawn)
    }
    
    private var isDetailScreenDrawn: Bool {
        let app = launchApp()
        let tables = app.tables[AccessibilityIdentifier.detailsTableView.rawValue]
            .waitForExistence(timeout: 1)
        let imageView = app.images[AccessibilityIdentifier.launchImgView.rawValue].waitForExistence(timeout: 1)
        
        let nameLabel = app.staticTexts[AccessibilityIdentifier.launchNameLabel.rawValue]
            .waitForExistence(timeout: 1)
        
        let dateTimeLabel = app.staticTexts[AccessibilityIdentifier.launchDateTimeLabel.rawValue]
            .waitForExistence(timeout: 1)
        
        let flightNoLabel = app.staticTexts[AccessibilityIdentifier.launchFlightNoLabel.rawValue]
            .waitForExistence(timeout: 1)
        
        let payloadLabel = app.staticTexts[AccessibilityIdentifier.launchPayloadCountLabel.rawValue]
            .waitForExistence(timeout: 1)
        
//        let button = app.buttons[AccessibilityIdentifier.makeFavBtn.rawValue]
//        let favButton = button.waitForExistence(timeout: 1)
        
        let booleanArray = [tables, imageView, nameLabel, dateTimeLabel, flightNoLabel, payloadLabel]
        _ = booleanArray.map { print($0) }
        
        return booleanArray.reduce(true) { $0 && $1 }
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

extension XCUIApplication {
    func getTableCell(at index: Int) -> XCUIElement {
        let cell = tables[AccessibilityIdentifier.tableView.rawValue]
            .firstMatch
            .descendants(matching: .cell)
            .element(boundBy: index)
        return cell
    }
    
    func scrollTo(element cell: XCUIElement) {
        var swipeLimit = 0
        repeat {
            swipeUp(velocity: .default)
            swipeLimit += 1
        } while(cell.isHittable == true && swipeLimit < 10)
    }
}
