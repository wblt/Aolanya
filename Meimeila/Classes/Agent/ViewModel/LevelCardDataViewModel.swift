//
//  LevelCardDataViewModel.swift
//  Meimeila
//
//  Created by yanghuan on 2018/4/9.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON

class LevelCardDataViewModel: NSObject {
	
	var cardListArr = [LevelCardModel]()
	
	func getCardData(successBlock:@escaping () -> Void) {
		DDHTTPRequest.request(r: UserInfoAPI.userMemberLv, requestSuccess: { (result) in
			
			print(result);
			let json = JSON.init(result);
			let jsonArr = json["data"].arrayValue;
			for items in jsonArr {
				let model = LevelCardModel.init(fromJson: items)
				self.cardListArr.append(model);
			}
			
			BFunction.shared.showToastMessge(json["message"].stringValue)
			successBlock()
			
		}, requestError: { (result, errorModel) in
			
			 BFunction.shared.showToastMessge(errorModel.message);
			
		}) { (error) in
			
		}
	}
}
