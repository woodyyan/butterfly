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
    func fetchNewButterflies(complete: @escaping (Bool) -> Void) {
        let provider = MoyaProvider<ButterflyAPI>()
        provider.request(ButterflyAPI.searchButterfly(page: 0, size: 20)) { (result) in
            switch result {
            case let .success(response):
                let data = response.data
                if let butterflyData = ButterflyData(JSONString: String(data: data, encoding: String.Encoding.utf8)!) {
                    self.saveToLocal(data: butterflyData)
                    complete(true)
                }
            case let .failure(error):
                print(error)
                complete(false)
            }
        }
    }
    
    private func saveToLocal(data: ButterflyData) {
        let context = CoreStorage.shared.persistentContainer.viewContext
        let storage = ButterflyStorage(context: context)
        for butterfly in data.butterflies {
            storage.save(butterfly: butterfly)
        }
    }
}
