//
//  AppDelegate.swift
//  DIPAssignment
//
//  Created by Tejas Patelia on 15/06/21.
//

import UIKit
import AppCenter
import AppCenterAnalytics
import AppCenterCrashes

let appCenterKey = "2a2d64ac-0306-4022-a90b-ea8e541b969e"
@main
class AppDelegate: UIResponder, UIApplicationDelegate {



	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AppCenter.start(withAppSecret: appCenterKey, services:[
            Analytics.self,
            Crashes.self
        ])
		return true
	}

	// MARK: UISceneSession Lifecycle

	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
		return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
	}

	func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
	}


}

