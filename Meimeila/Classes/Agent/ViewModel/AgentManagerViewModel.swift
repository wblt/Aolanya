//
//  AgentManagerViewModel.swift
//  Meimeila
//
//  Created by wy on 2018/4/16.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON

class AgentManagerViewModel: NSObject {

    var superiorAgentModel:AgentInfoDataModel?
    var lowerAgentArray = [AgentInfoDataModel]()
    
    func getAgentManagerData(uid:String,successBlock:@escaping () -> Void){
        
        let r = AgentManageAPI.getAgentManageAPI(uid: uid)
        
        DDHTTPRequest.request(r: r, requestSuccess: { (responds) in
            print(responds);
            let json = JSON.init(responds);
            
            self.superiorAgentModel = AgentInfoDataModel.init(fromJson: json["data"]["superiorAgent"])
            let jsonArr = json["data"]["lowerAgent"].arrayValue;
            
            for items in jsonArr {
                let model = AgentInfoDataModel.init(fromJson: items)
                self.lowerAgentArray.append(model);
            }
            BFunction.shared.showToastMessge(json["message"].stringValue);
            successBlock()
        }, requestError: { (responds, ErrorModel) in
            BFunction.shared.showToastMessge(ErrorModel.message);
        }) { (error) in
            
        }
        
    }
}
