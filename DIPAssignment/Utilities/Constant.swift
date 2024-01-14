//
//  Constant.swift
//  PayPayAssignment
//
//  Created by Tejas on 15/06/21.
//  Copyright © 2020 Tejas Patelia. All rights reserved.
//

import Foundation
import UIKit

public struct Constant {
	
	struct API_URLS {
		static let get_launches: String = "https://api.spacexdata.com/v4/launches"
		static let get_payloadperlaunch: String = "https://api.spacexdata.com/v4/payloads/"
		static let post_url: String = "https://httpbin.org/post"
	}

	struct UserDefaultKey{
		static let Test = "Test"
	}

	//30 Seconds time refresh
	struct APICallRefresh {
		static let Time = 30.0
	}
}



