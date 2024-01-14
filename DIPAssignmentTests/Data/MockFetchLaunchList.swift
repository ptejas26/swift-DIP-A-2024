//
//  MockFetchLaunchList.swift
//  DIPAssignment
//
//  Created by Tejas Patelia on 16/06/21.
//

import Foundation
@testable import DIPAssignment

class MockFetchLaunchList {
	var isSuccess = true

	func fetchLaunchList(completionHandler: @escaping CompletionBlockWithResult<[Launch]>) {

		if isSuccess {
			let stubGenerator = StubGenerator()
			if let data = stubGenerator.getLaunchData() {

				let decoder = JSONDecoder()
				do {
					let parseData = try decoder.decode([Launch].self, from: data)
					completionHandler(.success(parseData))
				} catch let error {
					completionHandler(.failure(error))
				}
			} else {
				completionHandler(.failure(customError))
			}
		}
	}
}

