//
//  StubGenerator.swift
//  DIPAssignment
//
//  Created by Tejas Patelia on 15/06/21.
//

import Foundation

class StubGenerator {
	private func getFileContentsAsJson(fileUrl: URL) -> Data? {
		if let data = try? Data(contentsOf: fileUrl) {
			return data
		}
		return nil
	}

	func getLaunchData() -> Data? {
		let testBundle = Bundle(for: type(of: self))

		if let fileUrl = testBundle.url(forResource: "LaunchInfo", withExtension: "json") {
			if let data = getFileContentsAsJson(fileUrl: fileUrl) {
				return data
			}
		}
		return nil
	}
}
