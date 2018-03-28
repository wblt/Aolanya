//
//  MMLSearchViewModel.swift
//  Meimeila
//
//  Created by HJQ on 2017/10/20.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON

class MMLSearchViewModel {

    var hotSearchKeywords: MMLHotSearchKeywordModel?
    // 获取热搜关键字
    func getHotSearchKeywords(successBlock: @escaping () -> ()) {
        DDHTTPRequest.request(r: HotSearchAPI.getHotSearchKeywords, requestSuccess: { (result) in
            self.hotSearchKeywords = MMLHotSearchKeywordModel.init(fromJson: JSON.init(result))
            successBlock()
        }, requestError: { (result, errorModel) in
            
        }) { (error) in
            
        }
    }
}
