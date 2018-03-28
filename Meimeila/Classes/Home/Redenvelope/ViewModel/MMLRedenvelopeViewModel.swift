//
//  MMLRedenvelopeViewModel.swift
//  Meimeila
//
//  Created by HJQ on 2017/10/21.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON

class MMLRedenvelopeViewModel {

    func redenvelopeRecive(type: Int, successBlock: @escaping (_ meney: Double)->()) {
        let request = RedenvelopeAPI.receiveRedenvelope(type: type)
        DDHTTPRequest.request(r: request, requestSuccess: { (result) in
            let jsonData = JSON.init(result)
            //let message = jsonData["message"].stringValue
            let money = jsonData["moneySignRed"].doubleValue
            //BFunction.shared.showToastMessge(message)
            successBlock(money)
            
        }, requestError: { (result, errorModel) in
            BFunction.shared.showToastMessge(errorModel.message)
        }) { (error) in
            
        }
    }
}
