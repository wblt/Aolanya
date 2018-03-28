//
//  DDShoppingCarListData.swift
//  Mythsbears
//
//  Created by HJQ on 2017/10/9.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import Foundation
import SwiftyJSON

class DDShoppingCarListData{
    
    var businessID : String!
    var collectionCount : String!
    var discount : String!
    var isFrozen : String!
    var price : String!
    var readingCount : String!
    var salesCount : String!
    var shopingID : String!
    var shopingImg : String!
    var shopingMessage : String!
    var shopingName : String!
    var shopingNumber : String!
    var shoppingCartID : String!
    var shoppingCartNumber : String!
    var shoppingIsRelease : String!
    var shoppingSource : String!
    var shoppingTime : String!
    var shoppingType : String!
    var specifications : String!
    var uid : String!
    ///邮费
    var postage : String!
    // 用来记录该商品的状态
    var isSelectedDeleted: Bool = false
    var isSelectedPay: Bool = false
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        businessID = json["businessID"].stringValue
        collectionCount = json["collectionCount"].stringValue
        discount = json["discount"].stringValue
        isFrozen = json["isFrozen"].stringValue
        price = json["price"].stringValue
        readingCount = json["readingCount"].stringValue
        salesCount = json["salesCount"].stringValue
        shopingID = json["shopingID"].stringValue
        shopingImg = json["shopingImg"].stringValue
        shopingMessage = json["shopingMessage"].stringValue
        shopingName = json["shopingName"].stringValue
        shopingNumber = json["shopingNumber"].stringValue
        shoppingCartID = json["shoppingCartID"].stringValue
        shoppingCartNumber = json["shoppingCartNumber"].stringValue
        shoppingIsRelease = json["shoppingIsRelease"].stringValue
        shoppingSource = json["shoppingSource"].stringValue
        shoppingTime = json["shoppingTime"].stringValue
        shoppingType = json["shoppingType"].stringValue
        specifications = json["specifications"].stringValue
        uid = json["uid"].stringValue
        postage = json["postage"].stringValue
    }
    
    init(from shopModel:ShopOrderInfoModel) {
        businessID = shopModel.shopingID;
        shopingName = shopModel.shopingName;
        price = shopModel.price;
        shopingImg = shopModel.shopingImg;
        shoppingCartNumber = shopModel.shoppingNumber
        shopingID = shopModel.shopingID;
    }
}
