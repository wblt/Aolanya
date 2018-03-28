//
//  MMLMoneyPayModel.swift
//  Meimeila
//
//  Created by macos on 2017/12/8.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLMoneyPayModel{

    var orders:String?
    var addressID:String?
    var orderID:String?
    var invoice:String?
    init(orders:String,addressID:String,orderID:String?,invoice:String?) {
        
        self.orders = orders;
        self.addressID = addressID;
        self.orderID = orderID;
        self.invoice = invoice;
    }
}
