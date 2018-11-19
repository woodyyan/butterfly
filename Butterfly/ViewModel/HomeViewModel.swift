//
//  HomeViewModel.swift
//  Butterfly
//
//  Created by Songbai Yan  on 2018/11/9.
//  Copyright © 2018 Songbai Yan . All rights reserved.
//

import Foundation
import Moya
import ObjectMapper

class HomeViewModel: BaseViewModel {
    var butterflySets = [ButterflyData]()
    
    override init() {
        // 这里应该是从本地数据库取数据
        // 从服务器获取数据应该是刷新的时候做
        let provider = MoyaProvider<ButterflyAPI>()
        provider.request(ButterflyAPI.searchButterfly(page: 0, size: 20)) { (result) in
            switch result {
            case let .success(response):
                let data = response.data
                let butterflyData = ButterflyData(JSONString: String(data: data, encoding: String.Encoding.utf8)!)
                print(butterflyData)
            case let .failure(error):
                print(error)
            }
        }
        
//        for _ in 0...1 {
//            var dailySet = ButterflyData(date: "today")
//            for _ in 0...2 {
//                var butterfly = Butterfly()
//                butterfly
//                butterfly.pictures.append("2")
//                butterfly.pictures.append("7")
//                butterfly.pictures.append("1")
//                butterfly.pictures.append("7")
//                butterfly.pictures.append("2")
//                butterfly.pictures.append("7")
//                butterfly.pictures.append("1")
//                butterfly.pictures.append("2")
//                butterfly.pictures.append("1")
//                dailySet.butterflies.append(butterfly)
//            }
//            butterflySets.append(dailySet)
//        }
    }
}
