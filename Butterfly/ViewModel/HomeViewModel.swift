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
    private var storage: ButterflyStorage!
    private var service: ButterflyService!
    
    var butterflySections = [ButterflySection]()
    
    init(storage: ButterflyStorage, service: ButterflyService) {
        super.init()
        
        self.storage = storage
        self.service = service
        
        service.fetchNewButterflies { (success) in
            if success {
                let butterflies = storage.fetch()
                print(butterflies)
            }
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
