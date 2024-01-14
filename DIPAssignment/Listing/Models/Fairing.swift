//
//	Fairing.swift

import Foundation

struct Fairing : Codable {

	let recovered : String?
	let recoveryAttempt : String?
	let reused : String?
	let ships : [String]?


	enum CodingKeys: String, CodingKey {
		case recovered = "recovered"
		case recoveryAttempt = "recovery_attempt"
		case reused = "reused"
		case ships = "ships"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		recovered = try values.decodeIfPresent(String.self, forKey: .recovered)
		recoveryAttempt = try values.decodeIfPresent(String.self, forKey: .recoveryAttempt)
		reused = try values.decodeIfPresent(String.self, forKey: .reused)
		ships = try values.decodeIfPresent([String].self, forKey: .ships)
	}


}
