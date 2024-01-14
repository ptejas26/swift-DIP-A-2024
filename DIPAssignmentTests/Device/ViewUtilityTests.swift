//
//  ViewUtilityTests.swift
//  DIPAssignment
//
//  Created by Tejas Patelia on 16/06/21.
//

import XCTest
@testable import DIPAssignment

class ViewUtilityTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

	func test_getLaunchViewController() {
		let controller = ViewUtility.getLaunchController()
		XCTAssertNotNil(controller, "Launch Controller should not be nil")
	}

	func test_getLaunchDetailViewController() {
		let controller = ViewUtility.getLaunchDetailsController()
		XCTAssertNotNil(controller, "Details Controller should not be nil")
	}
}
