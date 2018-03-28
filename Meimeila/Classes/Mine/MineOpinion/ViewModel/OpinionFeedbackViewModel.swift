//
//  OpinionFeedbackViewModel.swift
//  Mythsbears
//
//  Created by macos on 2017/11/16.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON
class OpinionFeedbackViewModel {

    static let shared = OpinionFeedbackViewModel.init();
    fileprivate init(){}
    
    
    func submit(feedbackMessage: String, feedbackPhone: String?, feedbackAdress: String?, feedbackType: String,succeeds:@escaping ()->(),errors:@escaping ()->()) {
        
        let r = OpinionFeedbackAPI.feedback(feedbackMessage: feedbackMessage, feedbackPhone: feedbackPhone, feedbackAdress: feedbackAdress, feedbackType: feedbackType)
        
        DDHTTPRequest.request(r: r, requestSuccess: { (responds) in
            
            let json = JSON.init(responds);
            let message = json["message"].stringValue;
            BFunction.shared.showSuccessMessage(message);
            succeeds()
        }, requestError: { (responds, errorModel) in
            
            errors()
            BFunction.shared.showErrorMessage(errorModel.message);
        }) { (error) in
            BFunction.shared.showSuccessMessage(error.localizedDescription);

            
        }
        
        
    }
    
}
