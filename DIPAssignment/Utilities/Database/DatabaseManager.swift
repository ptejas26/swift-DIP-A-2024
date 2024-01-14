//
//  DatabaseManager.swift
//  DIPAssignment
//
//  Created by Tejas Patelia on 20/06/21.
//

import Foundation
import RealmSwift

enum DatabaseRuntimeError: Error {
	case NoRealmSet
}

public final class DatabaseManager {
	private init() {}
	static let sharedInstance = DatabaseManager()

	public var realm: Realm = try! Realm()

	func setLaunchData(model: LaunchListDBModel) {
		try! realm.write {
			realm.add(model)
		}
	}

	func getLaunchData(launchID: String) -> Results<LaunchDBModel>? {
		let predicate = NSPredicate(format: "launchID = %@", launchID)
		let object = realm.objects(LaunchListDBModel.self)
		guard let updateModel = object.first?.launches.filter(predicate) else {return nil}
		return updateModel
	}

	func getAllLaunches() -> Results<LaunchListDBModel> {
		return realm.objects(LaunchListDBModel.self)
	}

	func setLaunchAsFavorite(for launchID: String, state: Bool) {
		let predicate = NSPredicate(format: "launchID = %@", launchID)
		let object = realm.objects(LaunchListDBModel.self)
		let updateModel = object.first?.launches.filter(predicate).first
		try! realm.write {
			updateModel?.isFavorite = state
		}
	}

	func getLaunchFavorite(for launchID: String) -> Bool {
		let predicate = NSPredicate(format: "launchID = %@", launchID)
		let object = realm.objects(LaunchListDBModel.self)
		let updateModel = object.first?.launches.filter(predicate).first
		return updateModel?.isFavorite ?? false
	}

	func getPayloadFilterState() -> Bool {
		return realm.objects(LaunchListDBModel.self).first?.payloadOnOff ?? false
	}

	func setPayloadFilterState(state: Bool) {
		let list = DatabaseManager.sharedInstance.getAllLaunches().first
		guard (list != nil) else {return}
		try? realm.write {
			list?.payloadOnOff = state
		}
	}

}
