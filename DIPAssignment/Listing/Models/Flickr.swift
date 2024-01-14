//
//	Flickr.swift

import Foundation

struct Flickr : Codable {

	let original : [String]?
	let small : [String]?


	enum CodingKeys: String, CodingKey {
		case original = "original"
		case small = "small"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		original = try values.decodeIfPresent([String].self, forKey: .original)
		small = try values.decodeIfPresent([String].self, forKey: .small)
	}


}
