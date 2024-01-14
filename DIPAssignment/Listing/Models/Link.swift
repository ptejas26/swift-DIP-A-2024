//
//	Link.swift

import Foundation

struct Link : Codable {

	let article : String?
	let flickr : Flickr?
	let patch : Patch?
	let presskit : String?
	let reddit : Reddit?
	let webcast : String?
	let wikipedia : String?
	let youtubeId : String?


	enum CodingKeys: String, CodingKey {
		case article = "article"
		case flickr = "flickr"
		case patch = "patch"
		case presskit = "presskit"
		case reddit = "reddit"
		case webcast = "webcast"
		case wikipedia = "wikipedia"
		case youtubeId = "youtube_id"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		article = try values.decodeIfPresent(String.self, forKey: .article)
		flickr = try values.decodeIfPresent(Flickr.self, forKey: .flickr)
		patch = try values.decodeIfPresent(Patch.self, forKey: .patch)
		presskit = try values.decodeIfPresent(String.self, forKey: .presskit)
		reddit = try values.decodeIfPresent(Reddit.self, forKey: .reddit)
		webcast = try values.decodeIfPresent(String.self, forKey: .webcast)
		wikipedia = try values.decodeIfPresent(String.self, forKey: .wikipedia)
		youtubeId = try values.decodeIfPresent(String.self, forKey: .youtubeId)
	}


}
