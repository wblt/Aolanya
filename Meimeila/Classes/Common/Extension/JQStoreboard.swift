//
//  JQSBName-Extension.swift
//  YSBRXSwift
//
//  Created by HJQ on 2017/6/11.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit


// 利用协议优化
protocol SBName {
    // 添加一个关联的类型
    associatedtype StoreboardName: RawRepresentable
}

extension SBName where StoreboardName.RawValue == String {
    
    static func nameFor(sbname: StoreboardName) -> String {
        
        return "\(sbname.rawValue)"
    }
}

class Storeboard: SBName {
    /// 获取sb
    static func getSBName(sbName: StoreboardName) -> String  {
        let name = nameFor(sbname: sbName)
        return name
    }
}

// 定义的sb名字
extension Storeboard {
    public enum StoreboardName: String {
        /// Main
        case Main
        /// Store
        case Store
        /// Home
        case Home
        /// Near
        case Near
        /// Mine
        case Mine
    }
}
