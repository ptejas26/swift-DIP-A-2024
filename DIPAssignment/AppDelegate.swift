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

let appCenterKey = "8429159a-60df-436e-a3c7-7bf03ddfb519"
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

