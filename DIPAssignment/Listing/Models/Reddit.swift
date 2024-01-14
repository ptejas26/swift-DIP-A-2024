//
//	Reddit.swift

import Foundation

struct Reddit : Codable {

	let campaign : String?
	let launch : String?
	let media : String?
	let recovery : String?


	enum CodingKeys: String, CodingKey {
		case campaign = "campaign"
		case launch = "launch"
		case media = "media"
		case recovery = "recovery"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		campaign = try values.decodeIfPresent(String.self, forKey: .campaign)
		launch = try values.decodeIfPresent(String.self, forKey: .launch)
		media = try values.decodeIfPresent(String.self, forKey: .media)
		recovery = try values.decodeIfPresent(String.self, forKey: .recovery)
	}


}
