//
//  StringDateTransfrom.swift
//  Butterfly
//
//  Created by Songbai Yan  on 2018/11/19.
//  Copyright © 2018 Songbai Yan . All rights reserved.
//

import Foundation
import ObjectMapper

class StringDateTransform: TransformType {
    typealias Object = Date
    
    typealias JSON = String
    
    func transformFromJSON(_ value: Any?) -> Object? {
        if let dateString = value as? String {
            return dateString.toDate()
        }
        return nil
    }
    
    func transformToJSON(_ value: Object?) -> JSON? {
        if let date = value {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            return formatter.string(from: date)
        }
        return nil
    }
}
