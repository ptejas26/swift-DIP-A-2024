//
//  ResponseStatusCode.swift
//  PayPayAssignment
//
//  Created by Tejas on 15/06/21.
//  Copyright © 2020 Tejas Patelia. All rights reserved.
//

import Foundation


public enum ResponseStatusCode : Int{
    case success = 200
    case internalServerError = 500
    case badRequest = 400
    case unauthorized = 401
}
