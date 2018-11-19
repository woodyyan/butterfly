//
//  ButterflySection.swift
//  Butterfly
//
//  Created by Songbai Yan  on 2018/11/19.
//  Copyright © 2018 Songbai Yan . All rights reserved.
//

import Foundation

struct ButterflySection {
    
    var title: String
    var butterflies: [Butterfly]
}

extension ButterflySection {
    var count: Int {
        return butterflies.count
    }
}
