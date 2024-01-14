//
//	Launch.swift

import Foundation

public struct Launch: Codable {

	let autoUpdate : Bool?
	let capsules : [String]?
	let cores : [Core]?
	let crew : [String]?
	let dateLocal : String?
	let datePrecision : String?
	let dateUnix : Int?
	let dateUtc : String?
	let details : String?
	let failures : [Failure]?
	let fairings : Fairing?
	let flightNumber : Int?
	let id : String?
	let launchLibraryId : String?
	let launchpad : String?
	let links : Link?
	let name : String?
	let net : Bool?
	var payloads : [String]?
	let rocket : String?
	let ships : [String]?
	let staticFireDateUnix : Int64?
	let staticFireDateUtc : String?
	let success : Bool?
	let tbd : Bool?
	let upcoming : Bool?
	let window : Int?
	var showPayload: Bool = false 
	var isFavorite: Bool = false
	var payload: [(name: String,type: String)] = []

	enum CodingKeys: String, CodingKey {
		case autoUpdate = "auto_update"
		case capsules = "capsules"
		case cores = "cores"
		case crew = "crew"
		case dateLocal = "date_local"
		case datePrecision = "date_precision"
		case dateUnix = "date_unix"
		case dateUtc = "date_utc"
		case details = "details"
		case failures = "failures"
		case fairings = "fairings"
		case flightNumber = "flight_number"
		case id = "id"
		case launchLibraryId = "launch_library_id"
		case launchpad = "launchpad"
		case links = "links"
		case name = "name"
		case net = "net"
		case payloads = "payloads"
		case rocket = "rocket"
		case ships = "ships"
		case staticFireDateUnix = "static_fire_date_unix"
		case staticFireDateUtc = "static_fire_date_utc"
		case success = "success"
		case tbd = "tbd"
		case upcoming = "upcoming"
		case window = "window"
	}

//	init() {
//		autoUpdate = false
//		capsules = []
//		cores = []
//		crew = []
//		dateLocal = ""
//		datePrecision = ""
//		dateUnix = 0
//		dateUtc = ""
//		details = ""
//		failures = []
//		fairings = nil
//		flightNumber = 0
//		id = ""
//		launchLibraryId = ""
//		launchpad = ""
//		links = nil
//		name = ""
//		net = false 
//		payloads = []
//		rocket = ""
//		ships = []
//		staticFireDateUnix = 0
//		staticFireDateUtc = ""
//		success = false
//		tbd = false
//		upcoming = false
//		window = 0
//
//	}


	public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		autoUpdate = try values.decodeIfPresent(Bool.self, forKey: .autoUpdate)
		capsules = try values.decodeIfPresent([String].self, forKey: .capsules)
		cores = try values.decodeIfPresent([Core].self, forKey: .cores)
		crew = try values.decodeIfPresent([String].self, forKey: .crew)
		dateLocal = try values.decodeIfPresent(String.self, forKey: .dateLocal)
		datePrecision = try values.decodeIfPresent(String.self, forKey: .datePrecision)
		dateUnix = try values.decodeIfPresent(Int.self, forKey: .dateUnix)
		dateUtc = try values.decodeIfPresent(String.self, forKey: .dateUtc)
		details = try values.decodeIfPresent(String.self, forKey: .details)
		failures = try values.decodeIfPresent([Failure].self, forKey: .failures)
		fairings = try Fairing(from: decoder)
		flightNumber = try values.decodeIfPresent(Int.self, forKey: .flightNumber)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		launchLibraryId = try values.decodeIfPresent(String.self, forKey: .launchLibraryId)
		launchpad = try values.decodeIfPresent(String.self, forKey: .launchpad)
		links = try values.decodeIfPresent(Link.self, forKey: .links)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		net = try values.decodeIfPresent(Bool.self, forKey: .net)
		payloads = try values.decodeIfPresent([String].self, forKey: .payloads)
		rocket = try values.decodeIfPresent(String.self, forKey: .rocket)
		ships = try values.decodeIfPresent([String].self, forKey: .ships)
		staticFireDateUnix = try values.decodeIfPresent(Int64.self, forKey: .staticFireDateUnix)
		staticFireDateUtc = try values.decodeIfPresent(String.self, forKey: .staticFireDateUtc)
		success = try values.decodeIfPresent(Bool.self, forKey: .success)
		tbd = try values.decodeIfPresent(Bool.self, forKey: .tbd)
		upcoming = try values.decodeIfPresent(Bool.self, forKey: .upcoming)
		window = try values.decodeIfPresent(Int.self, forKey: .window)
	}


}
