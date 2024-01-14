//
//  Failure.swift
//  DIPAssignment
//
//  Created by Tejas Patelia on 16/06/21.
//

import Foundation

struct Failure : Codable {

	let time: Int?
	let altitude: CustomType?
	let reason: String?

	enum CodingKeys: String, CodingKey {
		case time = "time"
		case altitude = "altitude"
		case reason = "reason"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		time = try values.decodeIfPresent(Int.self, forKey: .time)
		altitude = try values.decodeIfPresent(CustomType.self, forKey: .altitude)
		reason = try values.decodeIfPresent(String.self, forKey: .reason)
	}


}
