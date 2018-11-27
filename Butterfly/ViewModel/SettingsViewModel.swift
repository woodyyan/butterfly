//
//  SettingsViewModel.swift
//  Butterfly
//
//  Created by Songbai Yan  on 2018/11/8.
//  Copyright © 2018 Songbai Yan . All rights reserved.
//

import Foundation

class SettingsViewModel: BaseViewModel {
    private var storage: FavStorage!
    var settings: Settings!
    
    init(storage: FavStorage) {
        super.init()
        
        self.storage = storage
    }
    
    func initSettings() {
        settings = Settings()
        
        var subscriptionSection = Section()
        var subscriptionItem = SettingItem(title: "订阅")
        subscriptionItem.detailText = "过期"
        subscriptionItem.icon = "subscription"
        subscriptionSection.items.append(subscriptionItem)
        settings.sections.append(subscriptionSection)
        
        var favSection = Section()
        var favItem = SettingItem(title: "收藏")
        favItem.detailText = "\(storage.totalCount())张"
        favItem.icon = "fav"
        favSection.items.append(favItem)
        settings.sections.append(favSection)
        
        var helpSection = Section()
        var shareItem = SettingItem(title: "分享")
        shareItem.icon = "share"
        helpSection.items.append(shareItem)
        var commentItem = SettingItem(title: "评分")
        commentItem.icon = "AppStore"
        helpSection.items.append(commentItem)
        var feedbackItem = SettingItem(title: "反馈")
        feedbackItem.icon = "feedback"
        helpSection.items.append(feedbackItem)
        settings.sections.append(helpSection)
        
        var aboutSection = Section()
        var aboutItem = SettingItem(title: "关于")
        aboutItem.detailText = "V \(getVersion())"
        aboutSection.items.append(aboutItem)
        settings.sections.append(aboutSection)
    }
    
    func getVersion() -> String {
        guard let infoDic = Bundle.main.infoDictionary else {return ""}
        guard let currentVersion = infoDic["CFBundleShortVersionString"] as? String else {return ""}
        //        let buildVersion = infoDic["CFBundleVersion"] as? String
        return currentVersion
    }
}
