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
	
	//获取 代理级别信息
	func getCardData(successBlock:@escaping () -> Void) {
		
		
		DDHTTPRequest.request(r: UserInfoAPI.userMemberLv, requestSuccess: { (result) in
			
			print(result);
			let json = JSON.init(result);
			let jsonArr = json["data"].arrayValue;
			for items in jsonArr {
				let model = LevelCardModel.init(fromJson: items)
				self.cardListArr.append(model);
			}
			
			successBlock()
			
		}, requestError: { (result, errorModel) in
			
			 BFunction.shared.showToastMessge(errorModel.message);
			
		}) { (error) in
			
		}
	}
	
	// 验证邀请码是否正确
	func checkInvitationCode(Code:String ,successBlock:@escaping () -> Void) {
		
		DDHTTPRequest.request(r: AgentApplyAPI.invitationCodeAPI(code: Code), requestSuccess: { (result) in
			
			print(result);
		//	let json = JSON.init(result);
			
			successBlock()
			
		}, requestError: { (result, errorModel) in
			
			BFunction.shared.showToastMessge(errorModel.message);
			
		}) { (error) in
			
		}
		
	}
	
}
