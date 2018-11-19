//
//  PictureSet.swift
//  Butterfly
//
//  Created by Songbai Yan  on 2018/11/9.
//  Copyright © 2018 Songbai Yan . All rights reserved.
//

import Foundation
import ObjectMapper

struct ButterflyData: Mappable {
    var meta: Meta!
    var butterflies = [Butterfly]()
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        meta <- map["meta"]
        butterflies <- map["data"]
    }
}
