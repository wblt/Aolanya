//
//  NSData-Extension.swift
//  Mythsbears
//
//  Created by HJQ on 2017/9/30.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import Foundation

extension Data {

    /// Data -> Array, Dictionary
    ///
    /// - Returns: Array
    func toArray() -> [Any]? {
        
        return toArrayOrDictionary() as? [Any]
    }
    
    /// Data -> Array, Dictionary
    ///
    /// - Returns: Array
    func toDictionary() -> [String:Any]? {
        
        return toArrayOrDictionary() as? [String:Any]
    }
    
    /// Data -> Array, Dictionary
    ///
    /// - Returns: Any
    fileprivate func toArrayOrDictionary() -> Any? {
        
        do {
            
            let data = try JSONSerialization.jsonObject(with: self, options: JSONSerialization.ReadingOptions.allowFragments)
            
            return data
        } catch let error {
            
            debugLog("\(error)")
            return nil
        }
    }
}
