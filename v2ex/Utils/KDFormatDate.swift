//
//  KDFormatDate.swift
//  v2ex
//
//  Created by donghao on 2017/9/24.
//  Copyright © 2017年 kyle. All rights reserved.
//

import UIKit

extension NSDate {
    
    func formatDate() -> String {
        let calendar = Calendar.current
        if calendar.isDateInToday(self as Date) {
            let since = Int(Date().timeIntervalSince(self as Date))
            if since < 60 {
                return "刚刚"
            }
            if since < 60 * 60 {
                return "\(since/60)分钟前"
            }
            return "\(since / (60 * 60))小时前"
        }
        
        var formatterString = " HH:mm"
        if calendar.isDateInYesterday(self as Date) {
            formatterString = "昨天" + formatterString
        } else {
            formatterString = "MM-dd" + formatterString
            let comps = calendar.dateComponents([Calendar.Component.year], from: self as Date, to: Date())
            if comps.year! >= 1 {
                formatterString = "yyyy-" + formatterString
            }
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = formatterString
        formatter.locale = NSLocale(localeIdentifier: "en") as Locale
        return formatter.string(from: self as Date)
    }
}

extension Int {
    
    func formatDate() -> String {
        let timeInterval: TimeInterval = TimeInterval(self)
        let date = NSDate(timeIntervalSince1970: timeInterval)
        return date.formatDate()
    }
    
}
