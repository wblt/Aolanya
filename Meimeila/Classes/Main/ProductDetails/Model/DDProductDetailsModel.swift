//
//  DDProductDetailsModel.swift
//  Mythsbears
//
//  Created by HJQ on 2017/10/9.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON

class DDProductDetailsModel {

    var banner : [DDProductDetailsBanner]!
    var code : String!
    var evaluateData : MMLProductDetailsEvaluateData!
    var message : String!
    var productDetails : DDProductDetailsProductDetail!
    var shoppingData : DDProductDetailsShoppingData!
    var shoppingIntroduce : [DDProductDetailsShoppingIntroduce]!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        banner = [DDProductDetailsBanner]()
        let bannerArray = json["banner"].arrayValue
        for bannerJson in bannerArray{
            let value = DDProductDetailsBanner.init(fromJson: bannerJson)
            banner.append(value)
        }
        code = json["code"].stringValue
        
        let  evalueDataJson = json["evaluateData"]
        if !evalueDataJson.isEmpty {
           evaluateData =  MMLProductDetailsEvaluateData.init(fromJson: evalueDataJson)
        }
        message = json["message"].stringValue
        let productDetailsJson = json["productDetails"]
        if !productDetailsJson.isEmpty{
            productDetails = DDProductDetailsProductDetail(fromJson: productDetailsJson)
        }
        let shoppingDataJson = json["shoppingData"]
        if !shoppingDataJson.isEmpty{
            shoppingData = DDProductDetailsShoppingData(fromJson: shoppingDataJson)
        }
        shoppingIntroduce = [DDProductDetailsShoppingIntroduce]()
        let shoppingIntroduceArray = json["shoppingIntroduce"].arrayValue
        for shoppingIntroduceJson in shoppingIntroduceArray{
            let value = DDProductDetailsShoppingIntroduce.init(fromJson: shoppingIntroduceJson)
            shoppingIntroduce.append(value)
        }
    }
    
}
