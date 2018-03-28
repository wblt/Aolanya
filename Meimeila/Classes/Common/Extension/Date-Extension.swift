//
//  Date-Extension.swift
//  Mythsbears
//
//  Created by HJQ on 2017/10/6.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import Foundation
import UIKit

extension Date {
    /**
     当前时间
     
     - returns: 时间格式: yyyy-MM-dd HH:mm:ss
     */
    static func currentTime() -> String {
        return Date.currentTimeWithFormar("yyyy-MM-dd HH:mm:ss")
    }
    
    static func currentTimeWithFormar(_ format: String) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: Date())
    }
    func string(with format: String) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    /**
     当前时间戳
     
     - returns: 时间戳
     */
    static func currentTimestamp() -> TimeInterval {
        
        let date: Date = Date(timeIntervalSinceNow: 0)
        return date.timeIntervalSince1970 * 1000
    }
    
    /**
     <#Description#>
     
     - returns: <#return value description#>
     */
    func dateWithTimestamp() -> String {
        return String(Int64(self.timeIntervalSince1970 * 1000))
    }
}
