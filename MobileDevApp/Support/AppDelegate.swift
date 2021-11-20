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
		return true
	}

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MobileDevApp")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
