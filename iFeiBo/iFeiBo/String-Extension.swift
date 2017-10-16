//
//  String-Extension.swift
//  iFeiBo
//
//  Created by Alexcai on 2017/9/23.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

import Foundation


extension String{
    
    /** 获取微博文本的A标签内容 */
    func getTagAHtmlText() -> String {
        guard self != "" else { return "" }
        let alocation = (self as NSString).range(of: ">").location + 1
        let aLength = (self as NSString).range(of: "</").location - alocation
        return "来自" + (self as NSString).substring(with: NSMakeRange(alocation, aLength))
    }
    /** 转换时间表达方法 */
    func convertWBTime() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE MM dd HH:mm:ss Z yyyy"
        formatter.locale = Locale(identifier: "en")
        guard let wb_date = formatter.date(from: self) else { return "" }
        
        let interval = Int(Date().timeIntervalSince(wb_date))
        if interval < 60 {return "刚刚"}
        if interval < 60 * 60 { return "\(interval / 60)分钟前"}
        if interval < 60 * 60 * 24 {return "\(interval / (60 * 60))小时前"}
        
        let cale = Calendar.current
        if cale.isDateInYesterday(wb_date) {
            formatter.dateFormat = "昨天 HH:mm"
            return formatter.string(from: wb_date)
        }
        let cmp = cale.dateComponents([.year], from: wb_date, to: Date())
        guard let year = cmp.year else { return "" }
        if year < 1 {
            formatter.dateFormat = "MM-dd HH:mm"
            return formatter.string(from: wb_date)
        }
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter.string(from: wb_date)
    }
}
