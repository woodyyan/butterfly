//
//  Settings.swift
//  Butterfly
//
//  Created by Songbai Yan  on 2018/11/8.
//  Copyright © 2018 Songbai Yan . All rights reserved.
//

import Foundation

struct Settings {
    var sections = [Section]()
    
    func getSection(index: Int) -> Section {
        return sections[index]
    }
    
    func getSettingItem(_ indexPath: IndexPath) -> SettingItem {
        return sections[indexPath.section].items[indexPath.row]
    }
}
