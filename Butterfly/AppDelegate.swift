//
//  AppDelegate.swift
//  Butterfly
//
//  Created by Songbai Yan  on 2018/11/4.
//  Copyright © 2018 Songbai Yan . All rights reserved.
//

import UIKit
import CoreData
import SwiftyStoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window!.rootViewController = UINavigationController.init(rootViewController: HomeViewController())
        
        initAliyunService()
        
        SwiftyStoreKit.completeTransactions { (purchases) in
            for purchase in purchases {
                switch purchase.transaction.transactionState {
                case .purchased, .restored:
                    if purchase.needsFinishTransaction {
                        // Deliver content from server, then:
                        SwiftyStoreKit.finishTransaction(purchase.transaction)
                    }
                // Unlock content
                    SubscriptionManager.shared.setSubscriptionStatus(productId: purchase.productId)
                case .failed, .purchasing, .deferred:
                    break // do nothing
                }
            }
        }
        
        return true
    }
    
    private func initAliyunService() {
        let man = ALBBMANAnalytics.getInstance()
        man?.autoInit()
//        man?.turnOnDebug()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        CoreStorage.shared.saveContext()
    }
}
