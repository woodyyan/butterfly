//
//  DateExtension.swift
//  Butterfly
//
//  Created by Songbai Yan  on 2018/11/19.
//  Copyright © 2018 Songbai Yan . All rights reserved.
//

import Foundation

extension Date {
    func toTitleString() -> String {
        // 今日  2018.Oct.1
        if checkIsToday() {
            return "Today"
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy.MMM.dd"
            return formatter.string(from: self)
        }
    }
    
    func toStandardString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter.string(from: self)
    }
    
    private func checkIsToday() -> Bool {
        let calendar = Calendar.current
        let todayComs = calendar.dateComponents(in: TimeZone.current, from: Date())
        let today = todayComs.year!.description + todayComs.month!.description + todayComs.day!.description
        let dateComs = calendar.dateComponents(in: TimeZone.current, from: self)
        let date = dateComs.year!.description + dateComs.month!.description + dateComs.day!.description
        return today == date
    }
}
