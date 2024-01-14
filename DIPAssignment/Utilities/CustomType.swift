//
//  CustomType.swift
//  PayPayAssignment
//
//  Created by Tejas on 15/06/21.
//  Copyright © 2020 Tejas Patelia. All rights reserved.
//

import Foundation

public struct RuntimeError: Error {
	private let message: String
	
	public init(_ message: String) {
		self.message = message
	}
	
	var localizedDescription: String {
		return message
	}
}

// Sometimes JSON value returned in String as well as Int
public enum CustomType: Codable {
	public func encode(to encoder: Encoder) throws {
		
	}
	
	case int(Int), float(Float), string(String), bool(Bool)
	
	public init(from decoder: Decoder) throws {
		if let int = try? decoder.singleValueContainer().decode(Int.self) {
			self = .int(int)
			return
		}
		
		if let float = try? decoder.singleValueContainer().decode(Float.self) {
			self = .float(float)
			return
		}
		
		if let str = try? decoder.singleValueContainer().decode(String.self) {
			self = .string(str)
			return
		}
		if let bool = try? decoder.singleValueContainer().decode(Bool.self) {
			self = .bool(bool)
			return
		}
		throw RuntimeError("No such key found")
	}
}
