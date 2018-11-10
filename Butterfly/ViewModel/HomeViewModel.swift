//
//  HomeViewModel.swift
//  Butterfly
//
//  Created by Songbai Yan  on 2018/11/9.
//  Copyright © 2018 Songbai Yan . All rights reserved.
//

import Foundation

class HomeViewModel: BaseViewModel {
    var butterflySets = [ButterflyDailySet]()
    
    override init() {
        for _ in 0...1 {
            var dailySet = ButterflyDailySet(date: "today")
            for _ in 0...2 {
                var butterfly = Butterfly(name: "仓进空")
                butterfly.pictures.append("2")
                butterfly.pictures.append("7")
                butterfly.pictures.append("1")
                butterfly.pictures.append("7")
                butterfly.pictures.append("2")
                butterfly.pictures.append("7")
                butterfly.pictures.append("1")
                butterfly.pictures.append("2")
                butterfly.pictures.append("1")
                dailySet.butterflies.append(butterfly)
            }
            butterflySets.append(dailySet)
        }
    }
}
