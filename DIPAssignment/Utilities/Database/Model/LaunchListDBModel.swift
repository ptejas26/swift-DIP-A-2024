//
//  LaunchListDBModel.swift
//  DIPAssignment
//
//  Created by Tejas Patelia on 20/06/21.
//

import Foundation

import RealmSwift

public final class LaunchListDBModel: Object {
	dynamic var launches = List<LaunchDBModel>()
	@objc dynamic var payloadOnOff: Bool = true

	convenience init(list: List<LaunchDBModel>, payloadState: Bool = true) {
		self.init()
		self.launches = list
		self.payloadOnOff = payloadState
	}
}
