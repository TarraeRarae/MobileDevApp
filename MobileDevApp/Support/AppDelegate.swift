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
import CallKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
    var callObserver: CXCallObserver?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let viewController = AuthenticationViewController()
		let navigationController = UINavigationController(rootViewController: viewController)
		window = UIWindow(frame: UIScreen.main.bounds)
		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        callObserver = CXCallObserver()
        callObserver?.setDelegate(self, queue: nil)
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .moviePlayback, options: [])
        } catch {
            print("Failed to set audio session category.")
        }
		return true
	}
}

extension AppDelegate: CXCallObserverDelegate {

    func callObserver(_ callObserver: CXCallObserver, callChanged call: CXCall) {
        if call.hasEnded {
            TrackPlayerManager.shared.play()
            return
        }
        if call.isOutgoing && !call.hasConnected {
            TrackPlayerManager.shared.pause()
            return
        }
        if !call.isOutgoing && !call.hasConnected && !call.hasEnded {
            TrackPlayerManager.shared.pause()
            return
        }
    }
}
