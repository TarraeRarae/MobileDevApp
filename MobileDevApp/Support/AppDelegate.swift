//
//  AppDelegate.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 24.09.2021.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		let viewController = ViewController()
		let navigationControllet = UINavigationController(rootViewController: viewController)
		window = UIWindow(frame: UIScreen.main.bounds)
		window?.rootViewController = navigationControllet
		window?.makeKeyAndVisible()
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
		return true
	}
}
