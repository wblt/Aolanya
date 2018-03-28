//
//  DDShoppingCarListModel.swift
//  Mythsbears
//
//  Created by HJQ on 2017/10/9.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import Foundation
import SwiftyJSON

class DDShoppingCarListModel{
    
    var code : String!
    var data : [DDShoppingCarListData]!
    var message : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        code = json["code"].stringValue
        data = [DDShoppingCarListData]()
        let dataArray = json["data"].arrayValue
        for dataJson in dataArray{
            let value = DDShoppingCarListData(fromJson: dataJson)
            data.append(value)
        }
        message = json["message"].stringValue
    }
    
}
