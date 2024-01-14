//
//  LaunchTest.swift
//  DIPAssignment
//
//  Created by Tejas Patelia on 16/06/21.
//

import XCTest
@testable import DIPAssignment

class LaunchTest: XCTestCase {

	func test_LaunchLogic() {
		guard let launchModel = MockJSON.makeLaunch() else {return}

		let launchVM = ListingViewModel(launch: launchModel)
		XCTAssertEqual(launchVM.returnLaunchID(),"5eb87cd9ffd86e000604b32a", "LaunchID should be 5eb87cd9ffd86e000604b32a")
		XCTAssertEqual(launchVM.returnLaunchName(),"FalconSat", "Launch Name should be FalconSat")
		XCTAssertEqual(launchVM.returnLaunchDateTime(),"24-Mar-2006", "Launch Date should be 24-Mar-2006")
		XCTAssertEqual(launchVM.returnLaunchFlightNo(),"1", "Launch Date should be 1")
		XCTAssertEqual(launchVM.returnCountOfPayload(),"1", "Launch Payload count should be 1")
		XCTAssertEqual(launchVM.returnLaunchImageLink(),"https://images2.imgbox.com/3c/0e/T8iJcSN3_o.png", "Launch Image Link does not match")
		XCTAssertEqual(launchVM.returnLaunchImageLinkForDetails(),"https://images2.imgbox.com/40/e3/GypSkayF_o.png", "Launch Image Link does not match")
		XCTAssertEqual(launchVM.returnShowPayload(),false, "Launch payload should be false")
	}

}
