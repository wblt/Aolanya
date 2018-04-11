//
//  MMLMineSetViewModel.swift
//  Meimeila
//
//  Created by macos on 2017/12/9.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLMineSetViewModel{
    
    static let shared = MMLMineSetViewModel();
    fileprivate init(){}
    
    lazy var cellDic:[[String:String]] = {
        
//        let arr = [["name":"设置支付密码","icon":"icon_Lsms"],
//                   ["name":"绑定手机号","icon":"icon_Lphone"],
//                   ["name":"解除手机号绑定","icon":"icon_Lpass"]];
		
		let arr = [["name":"设置支付密码","icon":"icon_Lsms"],
				   ["name":"绑定手机号","icon":"icon_Lphone"],
				   ["name":"解除手机号绑定","icon":"icon_Lpass"],
				   ["name":"收货地址","icon":"icon_mineAddress"],
				   ["name":"意见反馈","icon":"icon_opinion"],
                   ["name":"关于","icon":"icon_opinion"]]
        return arr;
    }()

}
