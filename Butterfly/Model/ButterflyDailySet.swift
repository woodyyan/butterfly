//
//  PictureSet.swift
//  Butterfly
//
//  Created by Songbai Yan  on 2018/11/9.
//  Copyright © 2018 Songbai Yan . All rights reserved.
//

import Foundation

struct ButterflyDailySet {
    var date = ""
    var butterflies = [Butterfly]()
    
    var count: Int {
        return butterflies.count
    }
    
    init(date: String) {
        self.date = date
    }
}
