//
//  MMLUseRedPacketsViewModel.swift
//  Meimeila
//
//  Created by HJQ on 2017/11/22.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON

class MMLUseRedPacketsViewModel {
    
    func receiveRedEnvelope(shoppingID: String, successBlock: @escaping (_ money: Double) -> ()) {
        let request = UseRedPacketsAPI.useRedPackets(shopingID: shoppingID)
        DDHTTPRequest.request(r: request, requestSuccess: { (result) in
            let money = JSON.init(result)["money"].doubleValue
            successBlock(money)
        }, requestError: { (_, errorModel) in
            
            BFunction.shared.showToastMessge(errorModel.message)
            
        }) { (error) in
            
        }
    }

}
