//
//  SubscriptionManager.swift
//  Butterfly
//
//  Created by Songbai Yan  on 2018/11/20.
//  Copyright © 2018 Songbai Yan . All rights reserved.
//

import Foundation

class SubscriptionManager {
    private static var single: SubscriptionManager!
    
    static var shared: SubscriptionManager {
        if single == nil {
            single = SubscriptionManager()
        }
        return single
    }
    
    func isSubscribed() -> Bool {
        return false
    }
}
