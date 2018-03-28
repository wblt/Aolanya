//
//  DDJPushViewModel.swift
//  Mythsbears
//
//  Created by HJQ on 2017/11/15.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class DDJPushViewModel {
    
    // 上传机光推送的token
    func upLoadJPushRegistID() {
        let registID = DDUDManager.share.pushToken()
        let request = JPushAPI.uploadRegistID(registID: registID)
        DDHTTPRequest.request(r: request, requestSuccess: { (result) in
            
        }, requestError: { (_, errorModel) in
            
        }) { (error) in

        }
    }

}
