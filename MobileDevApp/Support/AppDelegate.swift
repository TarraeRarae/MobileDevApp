//
//  AppDelegate.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 24.09.2021.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift
import AVFoundation

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//		let viewController = AuthenticationViewController()
        let viewController = TrackListViewController()
		let navigationController = UINavigationController(rootViewController: viewController)
		window = UIWindow(frame: UIScreen.main.bounds)
		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .moviePlayback, options: [])
        } catch {
            print("Failed to set audio session category.")
        }
		return true
	}
}
