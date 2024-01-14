//
//  ViewUtility.swift
//  PayPayAssignment
//
//  Created by Tejas on 15/06/21.
//  Copyright © 2020 Tejas Patelia. All rights reserved.
//


import Foundation
import UIKit

public struct ViewUtility {

	// MARK: StoryBaord Utility Methods
	private static func getMainStoryBaord() -> UIStoryboard {
		return UIStoryboard(name: "Main", bundle: nil)
	}

	// MARK: ViewController Utility Methods
	static func getLaunchController() -> LaunchViewController? {
		let storyBoard = getMainStoryBaord()
		let id = "LaunchViewController"
		return storyBoard.instantiateViewController(withIdentifier: id) as? LaunchViewController
	}

	static func getLaunchDetailsController() -> LaunchDetailsViewController? {
		let storyBoard = getMainStoryBaord()
		let id = "LaunchDetailsViewController"
		return storyBoard.instantiateViewController(withIdentifier: id) as? LaunchDetailsViewController
	}

}
