//
//  BundleExtension.swift
//  Butterfly
//
//  Created by Songbai Yan  on 2018/11/29.
//  Copyright © 2018 Songbai Yan . All rights reserved.
//

import Foundation

extension Bundle {
    func getVersion() -> String {
        guard let infoDic = self.infoDictionary else {return ""}
        guard let currentVersion = infoDic["CFBundleShortVersionString"] as? String else {return ""}
        //        let buildVersion = infoDic["CFBundleVersion"] as? String
        return currentVersion
    }
}
