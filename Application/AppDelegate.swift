//
//  AppDelegate.swift
//  Application
//
//  Created by Yasser Aboibrahim on 01/05/2024.
//

import UIKit
import CoreData
import ModuleA

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Create your Module A Listing Screen View Controller
        let listingViewController = ModuleARouter.start()
        
        // Set Module A ViewController as the rootViewController of the window
        let navigationController = UINavigationController(rootViewController: listingViewController)
        window?.rootViewController = navigationController
        
        // Make the window visible
        window?.makeKeyAndVisible()
        return true
    }

}

