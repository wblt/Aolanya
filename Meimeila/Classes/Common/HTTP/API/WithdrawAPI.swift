//
//  WithdrawAPI.swift
//  Meimeila
//
//  Created by HJQ on 2017/10/23.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

// 提现相关
enum WithdrawAPI {
	case withdraw(type: Int, money: Double, alipay: String, realName: String,payImg: UIImage)
    case withdrawRecord()
}

extension WithdrawAPI: Request {
    var path: String {
        switch self {
        case .withdraw(_, _, _, _,_):
            return API.addWithdrawals
        case .withdrawRecord():
            return API.getWithdrawalsInfo
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .withdraw(let type, let money, let alipay, let realName,let payImg):
            var params = postParameters()
            params["type"] = "\(type)"
            params["money"] = "\(money)"
			params["alipay"] = alipay
			params["realName"] = realName
			params["source"] = "iOS APP"
			params["payImg"] = payImg
            return DDIntegrationOfTheParameter(params: params, isNeedLogin: true)
        case .withdrawRecord():
            let params = postParameters()
            return DDIntegrationOfTheParameter(params: params, isNeedLogin: true)
        }
    }
    
    
}
