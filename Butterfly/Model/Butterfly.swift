//
//  Butterfly.swift
//  Butterfly
//
//  Created by Songbai Yan  on 2018/11/9.
//  Copyright © 2018 Songbai Yan . All rights reserved.
//

import Foundation
import ObjectMapper

struct Butterfly: Mappable {
    var id: Int = 0
    var name: String = ""
    var butterflyId: Int = 0
    var setId: Int = 0
    var pictures = [String]()
    var createdDate: Date!
    var updatedDate: Date!
    
    init() {
        
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        butterflyId <- map["butterflyId"]
        setId <- map["setId"]
        pictures <- map["urls"]
        createdDate <- (map["createdTime"], StringDateTransform())
        updatedDate <- (map["updatedTime"], StringDateTransform())
    }
}
