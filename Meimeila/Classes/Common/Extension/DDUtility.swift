//
//  DDUtility.swift
//  Mythsbears
//
//  Created by HJQ on 2017/9/22.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class DDUtility {
    
    /// 延迟执行
    ///
    /// - parameter delay:   延迟时间
    /// - parameter closure: 延迟执行代码
    class func delay(_ delay:Double, closure: @escaping ()->Void) {
        
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }

}
