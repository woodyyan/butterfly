//
//  Meta.swift
//  Butterfly
//
//  Created by Songbai Yan  on 2018/11/15.
//  Copyright © 2018 Songbai Yan . All rights reserved.
//

import Foundation
import ObjectMapper

struct Meta: Mappable {
    var pageSize: Int = 10
    var pageNumber: Int = 0
    var totalPages: Int = 0
    var totalElements: Int = 0
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        pageSize <- map["pageSize"]
        pageNumber <- map["pageNumber"]
        totalPages <- map["totalPages"]
        totalElements <- map["totalElements"]
    }
}
