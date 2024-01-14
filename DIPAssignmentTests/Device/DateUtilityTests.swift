//
//  DateUtilityTests.swift
//  DIPAssignment
//
//  Created by Tejas Patelia on 16/06/21.
//

import XCTest
@testable import DIPAssignment

class DateUtilityTests: XCTestCase {

	func test_date_difference_greaterthan() {
		let currDate = Date()
		let futureDate = Date().addingTimeInterval(TimeInterval(10000))
		let diff = currDate.minutesBetweenDates(newDate: futureDate)
		XCTAssertGreaterThan(diff,0, "The difference should be greater than zero")
	}

	func test_date_difference_lessthan() {
		let epochTime = Int64(Date().timeIntervalSince1970) - 10000
		let currDate = Date()
		let futureDate = Date.init(timeIntervalSince1970: TimeInterval(epochTime))
		let diff = currDate.minutesBetweenDates(newDate: futureDate)
		XCTAssertLessThan(diff,0, "The difference should be less than zero")
	}

	func test_date_convertTimeStampToDateEqual() {
		let date = Utilities.convertTimestampToDate(ts: 1624372918)
		XCTAssertEqual(date, "22-Jun-2021","The date should be equal")
	}

	func test_date_convertTimeStampToDateZero() {
		let date = Utilities.convertTimestampToDate(ts: 0)
		XCTAssertEqual(date, "31-Dec-1969","The date should be equal")
	}

	func test_convertFromISODateNil() {
		let date = Utilities.convertFromISODate(strDate: "22-Jun-2021")
		XCTAssertNil(date)
	}

	func test_convertFromISODateFormat1() {
		let date = Utilities.convertDate(date: "2020-04-17T12:13:44.575Z", from: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", to: "dd-MMM-yyyy")
		XCTAssertNotNil(date)
		XCTAssertEqual(date, "17-Apr-2020", "Date should match")
	}

	func test_convertFromISODateFormat2() {
		let date = Utilities.convertDate(date: "22 Jun 2020", from: "dd MMM yyyy", to: "dd-MMMM-yyyy")
		XCTAssertNotNil(date)
		XCTAssertEqual(date, "22-June-2020", "Date should match")
	}

	func test_dayForDateNil() {
		let date = Date(timeIntervalSince1970: TimeInterval(0))
		let returnedDate = Utilities.dayForDate(date: date)
		XCTAssertEqual(returnedDate, "31", "Day should match")
	}

	func test_dayForDateEqual() {
		let date = Date(timeIntervalSince1970: TimeInterval(1624372918))
		let returnedDate = Utilities.dayForDate(date: date)
		XCTAssertEqual(returnedDate, "22", "Day should match")
	}
}
