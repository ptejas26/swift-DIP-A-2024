//
//	Core.swift

import Foundation

struct Core : Codable {

	let core : String?
	let flight : Int?
	let gridfins : Bool?
	let landingAttempt : Bool?
	let landingSuccess : Bool?
	let landingType : String?
	let landpad : String?
	let legs : Bool?
	let reused : Bool?


	enum CodingKeys: String, CodingKey {
		case core = "core"
		case flight = "flight"
		case gridfins = "gridfins"
		case landingAttempt = "landing_attempt"
		case landingSuccess = "landing_success"
		case landingType = "landing_type"
		case landpad = "landpad"
		case legs = "legs"
		case reused = "reused"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		core = try values.decodeIfPresent(String.self, forKey: .core)
		flight = try values.decodeIfPresent(Int.self, forKey: .flight)
		gridfins = try values.decodeIfPresent(Bool.self, forKey: .gridfins)
		landingAttempt = try values.decodeIfPresent(Bool.self, forKey: .landingAttempt)
		landingSuccess = try values.decodeIfPresent(Bool.self, forKey: .landingSuccess)
		landingType = try values.decodeIfPresent(String.self, forKey: .landingType)
		landpad = try values.decodeIfPresent(String.self, forKey: .landpad)
		legs = try values.decodeIfPresent(Bool.self, forKey: .legs)
		reused = try values.decodeIfPresent(Bool.self, forKey: .reused)
	}


}
