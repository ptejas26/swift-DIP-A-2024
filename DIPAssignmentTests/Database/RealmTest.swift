//
//  RealmTest.swift
//  DIPAssignmentTests
//
//  Created by Tejas Patelia on 22/06/21.
//

import XCTest
import RealmSwift
@testable import DIPAssignment

class RealmTest: XCTestCase {

    override func setUpWithError() throws {
		Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
		let realm = try! Realm()
		DatabaseManager.sharedInstance.realm = realm
    }

	func testSaveAndLaunch() {
		do {

			let launchModel = MockJSON.makeLaunch()
			let obj = LaunchDBModel(launchID: launchModel?.id ?? "", isFavorite: true, showPayload: true)
			let arrModel = List<LaunchDBModel>()
			arrModel.append(obj)
			let dbModel = LaunchListDBModel(list: arrModel, payloadState: true)
			DatabaseManager.sharedInstance.setLaunchData(model: dbModel)
			let launches = DatabaseManager.sharedInstance.getLaunchData(launchID: "5eb87cd9ffd86e000604b32a")
			XCTAssertNotNil(launches, "Launches should not be nil")
			XCTAssertEqual(launches?.count, Optional(1), "Count of Launches should be 1")
			let launch = launches?.first
			XCTAssertEqual(launch?.isFavorite, true, "This Launch should be favorite")
			XCTAssertEqual(launch?.showPayload, true, "This Launch should have payloads")
		} catch DatabaseRuntimeError.NoRealmSet {
			XCTAssert(false, "No realm database was set")
		} catch {
			XCTAssert(false, "Unexpected error \(error)")
		}
	}

	func test_showHidePayloadFalse() {
		do {
			var launchModel = MockJSON.makeLaunch()
			guard launchModel != nil else {return}
			launchModel?.payloads = []
			XCTAssertNotNil(launchModel, "LaunchModel should not be nil")
			let viewmodel = ListingViewModel()
			let status = viewmodel.filterAccordingToPayload(launch: launchModel!)
			XCTAssertEqual(status, false, "This launch should not be shown because payload is empty")
		} catch DatabaseRuntimeError.NoRealmSet {
			XCTAssert(false, "No realm database was set")
		} catch {
			XCTAssert(false, "Unexpected error \(error)")
		}
	}

	func test_showHidePayloadTrue() {
		do {
			let launchModel = MockJSON.makeLaunch()
			guard launchModel != nil else {return}
			XCTAssertNotNil(launchModel, "LaunchModel should not be nil")
			let viewmodel = ListingViewModel()
			let status = viewmodel.filterAccordingToPayload(launch: launchModel!)
			XCTAssertEqual(status, true, "This launch should be shown because payload is empty")
		} catch DatabaseRuntimeError.NoRealmSet {
			XCTAssert(false, "No realm database was set")
		} catch {
			XCTAssert(false, "Unexpected error \(error)")
		}
	}

}
