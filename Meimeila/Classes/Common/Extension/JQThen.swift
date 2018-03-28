//
//  JQThen.swift
//  SwiftTest
//
//  Created by MAC on 2017/1/3.
//  Copyright © 2017年 MAC. All rights reserved.
//

import Foundation
import UIKit

public protocol Then {}

extension Then where Self: Any {
    public func then_Any( block: (inout Self) -> Void) -> Self {
        var copy = self
        block(&copy)
        return copy
    }
    
    
    /*
     let  _ = UILabel().then_Any { (label) in
     label.backgroundColor = .blue
     label.font = UIFont.systemFont(ofSize: 18)
     label.textAlignment = .center
     label.text = "Then协议库"
     label.frame = CGRect.init(x: 20, y: 200, width: 150, height: 40)
     view.addSubview(label)
     }
     */
    
}


extension Then where Self: AnyObject {
    public func then( block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
    /*
     let  _ = UILabel().then { (label) in
     label.backgroundColor = .blue
     label.font = UIFont.systemFont(ofSize: 18)
     label.textAlignment = .center
     label.text = "Then协议库"
     label.frame = CGRect.init(x: 20, y: 200, width: 150, height: 40)
     view.addSubview(label)
     }
     */
    
    /*
     // 2.1 (推荐)无参数，无需命名，用$取参数，可自动联想属性
     let lable = UILabel().then {
     $0.backgroundColor = .blue
     $0.font = UIFont.systemFont(ofSize: 18)
     $0.textAlignment = .center
     $0.text = "Then库写法_2.1"
     $0.frame = CGRect.init(x: 200, y: 260, width: 150, height: 40)
     view.addSubview($0)
     }
     
     lable.backgroundColor = UIColor.red
     */
}


extension UIView: Then {}
