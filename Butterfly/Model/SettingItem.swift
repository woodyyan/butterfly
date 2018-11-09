//
//  SettingItem.swift
//  Butterfly
//
//  Created by Songbai Yan  on 2018/11/8.
//  Copyright © 2018 Songbai Yan . All rights reserved.
//

import Foundation
import UIKit

struct SettingItem {
    var title = ""
    var detailText: String?
    var icon: String?
    var height: CGFloat = 44
    
    init() {
    }
    
    init(title: String) {
        self.title = title
    }
}
