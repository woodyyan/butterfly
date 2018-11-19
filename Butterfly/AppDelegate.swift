//
//  AppDelegate.swift
//  Butterfly
//
//  Created by Songbai Yan  on 2018/11/4.
//  Copyright © 2018 Songbai Yan . All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window!.rootViewController = UINavigationController.init(rootViewController: HomeViewController())
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        CoreStorage.shared.saveContext()
    }
}
