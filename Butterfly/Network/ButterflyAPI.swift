//
//  ButterflyAPI.swift
//  Butterfly
//
//  Created by Songbai Yan  on 2018/11/15.
//  Copyright © 2018 Songbai Yan . All rights reserved.
//

import Foundation
import Moya

enum ButterflyAPI {
    case searchButterfly(page:  Int, size: Int)
}

extension ButterflyAPI: TargetType {
    var baseURL: URL {
        return URL(string: Configs.butterflyApiBaseUrl)!
    }
    
    var path: String {
        switch self {
        case .searchButterfly(page: _, size: _):
            return "/butterfly"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .searchButterfly(page: _, size: _):
            return .get
        }
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        return Task.requestPlain
    }
    
    var headers: [String: String]? {
        return ["Accept": "application/vnd.api+json"]
    }
}
