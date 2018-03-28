//
//  OpinionFeedbackAPI.swift
//  Mythsbears
//
//  Created by macos on 2017/11/16.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

enum OpinionFeedbackAPI{

    case feedback(feedbackMessage:String,feedbackPhone:String?,feedbackAdress:String?,feedbackType:String)
}

extension OpinionFeedbackAPI:Request{
    var path: String {
        switch self {
        case .feedback(feedbackMessage: _, feedbackPhone: _, feedbackAdress: _, feedbackType: _):
            return API.feedbackAPI;
        }
    }
    
    
    var parameters: [String : Any]?{
        
        
        switch self {
        case .feedback(let feedbackMessage,let feedbackPhone, let feedbackAdress,let feedbackType):
            
            var p = postParameters()
            p["feedbackMessage"] = feedbackMessage;
            p["feedbackType"] = feedbackType
            
            if let _ = feedbackPhone {
                p["feedbackPhone"] = feedbackPhone;
            }
            
            if let _ = feedbackAdress{
                p["feedbackAdress"] = feedbackAdress;
            }
            
            return DDIntegrationOfTheParameter(params:p , isNeedLogin: false);
        }
    }
    
}
