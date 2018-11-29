//
//  ButterflyService.swift
//  Butterfly
//
//  Created by Songbai Yan  on 2018/11/19.
//  Copyright © 2018 Songbai Yan . All rights reserved.
//

import Foundation
import Moya
import CoreData

class ButterflyService {
    func fetchNewButterflies(page: Int, complete: @escaping (Bool) -> Void) {
        let builder = ALBBMANNetworkHitBuilder.init(host: "butterfly", method: "GET")
        builder!.requestStart()
        let provider = MoyaProvider<ButterflyAPI>()
        provider.request(ButterflyAPI.searchButterfly(page: page, size: 20)) { (result) in
            builder?.requestEnd(withBytes: 0)
            switch result {
            case let .success(response):
                let data = response.data
                if let butterflyData = ButterflyData(JSONString: String(data: data, encoding: String.Encoding.utf8)!) {
                    let success = self.saveToLocal(data: butterflyData)
                    complete(success)
                }
            case let .failure(error):
                if let message = error.errorDescription {
                    let networkError = ALBBMANNetworkError.withHttpException5()
                    networkError?.setProperty("errorMessage", value: message)
                    builder!.requestEndWithError(networkError)
                }
                print(error)
                complete(false)
            }
            let tracker = ALBBMANAnalytics.getInstance()?.getDefaultTracker()
            tracker?.send(builder!.build())
        }
    }
    
    private func saveToLocal(data: ButterflyData) -> Bool {
        let context = CoreStorage.shared.persistentContainer.viewContext
        let storage = ButterflyStorage(context: context)
        var successCount = 0
        for butterfly in data.butterflies {
            let success = storage.save(butterfly: butterfly)
            if success {
                successCount += 1
            }
        }
        return successCount > 0
    }
}
