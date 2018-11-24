//
//  SubscriptionManager.swift
//  Butterfly
//
//  Created by Songbai Yan  on 2018/11/20.
//  Copyright © 2018 Songbai Yan . All rights reserved.
//

import Foundation
import SwiftyStoreKit

class SubscriptionManager {
    private static var single: SubscriptionManager!
    
    static var shared: SubscriptionManager {
        if single == nil {
            single = SubscriptionManager()
        }
        return single
    }
    
    func setSubscriptionStatus(productId: String) {
        var type = SubscriptionType.none
        if productId == Configs.memberMonthlyProductId {
            type = .monthly
        } else if productId == Configs.memberYearlyProductId {
            type = .yearly
        }
        
        UserDefaults.standard.set(type.rawValue, forKey: Configs.memberTypeKey)
        UserDefaults.standard.set(Date(), forKey: Configs.memberPurchaseDateKey)
        UserDefaults.standard.synchronize()
    }
    
    func isSubscribed() -> Bool {
        // date: 购买日期
        // type: 购买类型，月会员，年会员，none
        let result = UserDefaults.standard.integer(forKey: Configs.memberTypeKey)
        return result == SubscriptionType.monthly.rawValue || result == SubscriptionType.yearly.rawValue
    }
    
    // swiftlint:disable cyclomatic_complexity
    func purchase(type: SubscriptionType, completion: @escaping (Bool, String) -> Void) {
        let productId = type == SubscriptionType.monthly ? Configs.memberMonthlyProductId : Configs.memberYearlyProductId
        SwiftyStoreKit.purchaseProduct(productId, quantity: 1, atomically: true) { result in
            switch result {
            case .success(let purchase):
                self.setSubscriptionStatus(productId: purchase.productId)
                completion(true, "")
            case .error(let error):
                var message = ""
                switch error.code {
                case .unknown:
                    message = "未知错误。"
                case .clientInvalid:
                    message = "客户端不允许付款。"
                case .paymentCancelled:
                    message = "购买取消"
                case .paymentInvalid:
                    message = "购买标识符无效。"
                case .paymentNotAllowed:
                    message = "设备是不允许付款的。"
                case .storeProductNotAvailable:
                    message = "该产品在目前的商店是不可用的。"
                case .cloudServicePermissionDenied:
                    message = "不允许访问云服务信息。"
                case .cloudServiceNetworkConnectionFailed:
                    message = "无法连接网络。"
                case .cloudServiceRevoked:
                    message = "用户已撤销使用此云服务的权限。"
                default:
                    message = (error as NSError).localizedDescription
                }
                completion(false, message)
            }
        }
    }
}

enum SubscriptionType: Int {
    case none = 101
    case monthly = 103
    case yearly = 105
}
