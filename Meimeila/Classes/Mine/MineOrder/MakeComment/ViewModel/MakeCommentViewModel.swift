//
//  MakeCommentViewModel.swift
//  Mythsbears
//
//  Created by macos on 2017/11/15.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON
class MakeCommentViewModel{

    static let shared = MakeCommentViewModel();
    fileprivate init() {}
    
    
    
    
}

extension MakeCommentViewModel{
    
    func upLoadCommentWithImage(shopingID: String, orderID: String, evaluateMessage: String, files: [UIImage],scueeds:@escaping ()->(),errors:@escaping ()->()) {
        
        let r = ShopCommentAPI.addComment(shopingID: shopingID, orderID: orderID, evaluateMessage: evaluateMessage, files: files);

        DDHTTPRequest.upLoadImagesCommon(r: r, requestSuccess: { (responds) in
            
            print(responds);
            scueeds()
        }, requestError: { (responds, errorModel) in
            
            errors()
            
        }) { (error) in
            
        }
    }
    
}
