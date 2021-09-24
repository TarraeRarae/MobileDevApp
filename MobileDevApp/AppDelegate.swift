//
//  AppDelegate.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 24.09.2021.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		let vc = ViewController()
		let nvc = UINavigationController(rootViewController: vc)
		
		window = UIWindow(frame: UIScreen.main.bounds)
		window?.rootViewController = nvc
		window?.makeKeyAndVisible()
		
		return true
	}

	

}

