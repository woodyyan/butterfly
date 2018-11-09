//
//  SettingsViewModel.swift
//  Butterfly
//
//  Created by Songbai Yan  on 2018/11/8.
//  Copyright © 2018 Songbai Yan . All rights reserved.
//

import Foundation

class SettingsViewModel: BaseViewModel {
    var settings = Settings()
    
    override init() {
        super.init()
        
        initSettings()
    }
    
    private func initSettings() {
        var subscriptionSection = Section()
        var subscriptionItem = SettingItem(title: "订阅")
        subscriptionItem.detailText = "过期"
        subscriptionItem.icon = "subscription"
        subscriptionItem.height = 66
        subscriptionSection.items.append(subscriptionItem)
        settings.sections.append(subscriptionSection)
        
        var favSection = Section()
        var favItem = SettingItem(title: "收藏")
        favItem.detailText = "12张"
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
        aboutItem.detailText = "V 1.2"
        aboutSection.items.append(aboutItem)
        settings.sections.append(aboutSection)
    }
}
