//
//  DDProductDetailsShoppingData.swift
//  Mythsbears
//
//  Created by HJQ on 2017/10/9.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON

class DDProductDetailsShoppingData {

    var businessID : String!
    var collectionCount : String!
    var discount : Int = 0
    var isFrozen : String!
    var price : Double!
    var readingCount : String!
    var salesCount : String!
    var shopingID : String!
    var shopingImg : String!
    var shopingMessage : String!
    var shopingName : String!
    var shopingNumber : String!
    var shoppingIsRelease : String!
    var shoppingSource : String!
    var shoppingTime : String!
    var shoppingType : String!
    var specifications : String!
    var totalCollection : String!
    var market_value : Double!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        businessID = json["businessID"].stringValue
        collectionCount = json["collectionCount"].stringValue
        discount = json["discount"].intValue
        isFrozen = json["isFrozen"].stringValue
        price = json["price"].doubleValue
        readingCount = json["readingCount"].stringValue
        salesCount = json["salesCount"].stringValue
        shopingID = json["shopingID"].stringValue
        shopingImg = json["shopingImg"].stringValue
        shopingMessage = json["shopingMessage"].stringValue
        shopingName = json["shopingName"].stringValue
        shopingNumber = json["shopingNumber"].stringValue
        shoppingIsRelease = json["shoppingIsRelease"].stringValue
        shoppingSource = json["shoppingSource"].stringValue
        shoppingTime = json["shoppingTime"].stringValue
        shoppingType = json["shoppingType"].stringValue
        specifications = json["specifications"].stringValue
        totalCollection = json["totalCollection"].stringValue
        market_value = json["market_value"].doubleValue
    }
    
}
