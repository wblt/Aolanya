//
//  UserDefault-Extension.swift
//  SwiftTest
//
//  Created by MAC on 2017/2/13.
//  Copyright © 2017年 MAC. All rights reserved.
//

import Foundation
import UIKit

protocol UserDefaultNameSpace {}

extension UserDefaultNameSpace {
    static func namespace<T>(_ key:T) -> String where T: RawRepresentable {
        return "\(Self.self).\(key.rawValue)"
    }
}

protocol UserDefaultSettable: UserDefaultNameSpace {
    associatedtype UserDafaultKey: RawRepresentable
}

extension UserDefaultSettable where UserDafaultKey.RawValue == String {}

extension UserDefaultSettable {
    /// 关于 Int 类型的存储和读取
    static func set(value: Int, forKey key: UserDafaultKey) {
        let key = namespace(key)
        UserDefaults.standard.set(value, forKey: key)
        
    }
    
    /// 关于Bool 类型存储和读取
    static func set(value: Bool, forKey key: UserDafaultKey) {
        let key = namespace(key)
        UserDefaults.standard.set(value, forKey: key)
        
    }
    
    /// 关于 String 类型存储和读取
    static func set(value: Any?, forKey key: UserDafaultKey) {
        let key = namespace(key)
        UserDefaults.standard.set(value, forKey: key)
    }
    
    static func integer(forKey key: UserDafaultKey) -> Int?{
        let key = namespace(key)
        return UserDefaults.standard.integer(forKey: key)
    }
    
    static func bool(forKey key: UserDafaultKey) -> Bool?{
        let key = namespace(key)
        return UserDefaults.standard.bool(forKey: key)
    }
    
    static func string(forKey key: UserDafaultKey) -> String? {
        let key = namespace(key)
        return UserDefaults.standard.string(forKey: key)
    }
    
    static func removeObject(forkey key: UserDafaultKey) {
        let key = namespace(key)
        UserDefaults.standard.removeObject(forKey: key)
    }
}

//// MARK: - 使用方式
//extension UserDefaults {
//    struct Account: UserDefaultSettable {
//        enum  UserDafaultKey: String {
//            case username
//            case password
//        }
//    }
//}
//
//class test {
//    func testFunction() {
//        UserDefaults.Account.set(value: 20, forKey: .password)
//        UserDefaults.Account.set(value: "hjq", forKey: .username)
//    }
//
//}

