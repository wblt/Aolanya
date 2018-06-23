//
//  ShopCommentAPI.swift
//  Mythsbears
//
//  Created by macos on 2017/11/15.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

enum ShopCommentAPI{
    case addComment(shopingID:String,orderID:String,evaluateMessage:String,files:[UIImage]?)
}


extension ShopCommentAPI:Request{
    var path: String {

        switch self {
        case .addComment(shopingID: _, orderID: _, evaluateMessage: _, files: _):
            return API.commentAPI;
        }
    }
    
    var parameters: [String : Any]?{

        switch self {
        case .addComment(let shopingID,let orderID,let evaluateMessage,let files):
            var p = postParameters();
            p["shoppingID"] = shopingID;
            p["orderID"] = orderID;
           // p["fabulous"] = fabulous;
            
            p["evaluateMessage"] = evaluateMessage;
            
            if let images = files {
                
                if images.count > 0{
                    
                    for (index,value) in images.enumerated() {
                        
                        p["file\(index)"] = value
                    }
                }
                
            }
        
            return DDIntegrationOfTheParameter(params: p, isNeedLogin: true);

        
        }
    }
    
}

