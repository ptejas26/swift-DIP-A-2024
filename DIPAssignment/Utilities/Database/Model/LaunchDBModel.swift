//
//  LaunchDBModel.swift
//  DIPAssignment
//
//  Created by Tejas Patelia on 20/06/21.
//
import RealmSwift

public final class LaunchDBModel: Object {
	@objc dynamic var launchID = ""
	@objc dynamic var isFavorite: Bool = false
	@objc dynamic var showPayload: Bool = false

	convenience init(launchID: String = "", isFavorite: Bool = false, showPayload: Bool = false) {
		self.init()
		self.launchID = launchID
		self.isFavorite = isFavorite
		self.showPayload = showPayload
	}
}
