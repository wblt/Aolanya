//
//  AddressModel.swift
//  Mythsbears
//
//  Created by macos on 2017/10/14.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON

class AddressModel: NSObject {

    var addressID:String?
    var uid:String?
    var consignee:String?
    var localArea:String?
    var detailedAddress:String?
    var postcode:String?
    var defaultAddress:String?
    var addresseePhone:String?
    var whetherChange:String?
    var addAdress:String?
    
    init(fromJson json:JSON) {
        
        addressID = json["adressID"].stringValue
        uid = json["uid"].stringValue
        consignee = json["consignee"].stringValue
        localArea = json["localArea"].stringValue
        detailedAddress = json["detailedAddress"].stringValue
        postcode = json["postcode"].stringValue
        defaultAddress = json["defaultAddress"].stringValue
        addresseePhone = json["addresseePhone"].stringValue
        whetherChange = json["wetherChange"].stringValue
        addAdress = json["addAdress"].stringValue
        
        
    }
    
    override init() {
    }
}
