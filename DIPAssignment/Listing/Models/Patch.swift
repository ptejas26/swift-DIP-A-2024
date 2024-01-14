//
//	Patch.swift

import Foundation

struct Patch : Codable {

	let large : String?
	let small : String?


	enum CodingKeys: String, CodingKey {
		case large = "large"
		case small = "small"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		large = try values.decodeIfPresent(String.self, forKey: .large)
		small = try values.decodeIfPresent(String.self, forKey: .small)
	}


}
