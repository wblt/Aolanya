//
//  AgentManagerViewModel.swift
//  Meimeila
//
//  Created by wy on 2018/4/16.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON

class AgentManagerViewModel: NSObject {

    var superiorAgentModel:AgentInfoDataModel?
    var lowerAgentArray = [AgentInfoDataModel]()
	var toBeAuditedArray = [AgentInfoDataModel]()
	
	var regionShoppingArray = [RegionShoppingModel]()
	var subordinateShoppingArray = [SubordinateShoopingModel]()
	
	// 获取 上级、下级、 区域审核的数据
    func getAgentManagerData(uid:String,successBlock:@escaping () -> Void){
		self.lowerAgentArray.removeAll();
		self.toBeAuditedArray.removeAll();
		self.regionShoppingArray.removeAll();
		self.subordinateShoppingArray.removeAll();
		
        let r = AgentManageAPI.getAgentManageAPI(uid: uid)
        
        DDHTTPRequest.request(r: r, requestSuccess: { (responds) in
            let json = JSON.init(responds);
            self.superiorAgentModel = AgentInfoDataModel.init(fromJson: json["data"]["superiorAgent"])
            let jsonArr = json["data"]["lowerAgent"].arrayValue;
            let jsonArr1 = json["data"]["toBeAudited"].arrayValue;
			
            for items in jsonArr {
                let model = AgentInfoDataModel.init(fromJson: items)
                self.lowerAgentArray.append(model);
            }
			
			for items in jsonArr1 {
				let model = AgentInfoDataModel.init(fromJson: items)
				self.toBeAuditedArray.append(model);
			}
			
//			self.endRefresh(isNomore: isNomore)
			
            BFunction.shared.showToastMessge(json["message"].stringValue);
            successBlock()
        }, requestError: { (responds, ErrorModel) in
            BFunction.shared.showToastMessge(ErrorModel.message);
        }) { (error) in
            
        }
        
    }
	
	
	// 获取区域统计
	func getAllRegionShopingData(uid:String,successBlock:@escaping () -> Void) {
		
		 let r = AgentManageAPI.getAllRegionShoopingAPI(uid: uid)
		 DDHTTPRequest.requestWithJsonCoding(r: r, requestSuccess: { (responds) in
			let json = JSON.init(responds);
			
			let jsonArr = json["data"].arrayValue;
			for items in jsonArr {
				let model = RegionShoppingModel.init(fromJson: items)
				self.regionShoppingArray.append(model)
			}
			
			BFunction.shared.showToastMessge(json["message"].stringValue);
			successBlock()
		}, requestError: { (responds, ErrorModel) in
			BFunction.shared.showToastMessge(ErrorModel.message);
		}) { (error) in
			
		}
	}
	// 获取订单管理信息
	func getSubordinateShoppingData(uid:String,successBlock:@escaping () -> Void ) {
		let r = AgentManageAPI.getSubordinateShopping(uid: uid)
		DDHTTPRequest.requestWithJsonCoding(r: r, requestSuccess: { (responds) in
			let json = JSON.init(responds);
			
			let jsonArr = json["data"].arrayValue;
			for items in jsonArr {
				let model = SubordinateShoopingModel.init(fromJson: items)
				self.subordinateShoppingArray.append(model)
			}
			
			BFunction.shared.showToastMessge(json["message"].stringValue);
			successBlock()
		}, requestError: { (responds, ErrorModel) in
			BFunction.shared.showToastMessge(ErrorModel.message);
		}) { (error) in
			
		}
	}
	
	// 拒绝申请
	func confuseAgent(uid: String, targetUid: String, remarks: String, apply: String, toExamineoneUid: String,successBlock:@escaping () -> Void ) {
		
		let r = AgentManageAPI.agreenAgentAPI(uid: uid, targetUid: targetUid, remarks: remarks, apply: apply, toExamineoneUid: toExamineoneUid)
		
		DDHTTPRequest.upLoadImages(r: r, requestSuccess: { (responds) in
			
			let jsonRequest = JSON.init(responds);
			BFunction.shared.showSuccessMessage(jsonRequest["message"].stringValue);
			
			successBlock();
			
		}, requestError: { (responds, ErrorModel) in
			
			let jsonRequest = JSON.init(responds);
			let code = jsonRequest["code"].intValue
			var message:String?
			switch code {
			case 101:
				message = "请登录"
			case 102:
				message = "上传出错"
			case 103:
				message = "图片格式不正确"
			case 108:
				message = "请求超时"
			case 110:
				message = "签名不正确"
			case 111:
				message = " 未知错误"
			default:
				message = " Error"
			}
			
			//BFunction.shared.showErrorMessage(message!);
			BFunction.shared.showToastMessge(jsonRequest["message"].stringValue)
		}) { (error) in
			
		}
		
//		DDHTTPRequest.request(r: r, requestSuccess: { (responds) in
//			let json = JSON.init(responds);
//
//			BFunction.shared.showToastMessge(json["message"].stringValue);
//			successBlock()
//		}, requestError: { (responds, ErrorModel) in
//			BFunction.shared.showToastMessge(ErrorModel.message);
//		}) { (error) in
//
//		}
		
	
	}
	
	func agreenRegion(uid: String, targetUid: String, apply: String, agentLevel: String, level: String, inviter: String, regionLevel: String,successBlock:@escaping () -> Void ) {
		let r = AgentManageAPI.agreenRegionAPI(uid: uid, targetUid: targetUid, apply: apply, agentLevel: agentLevel, level: level, inviter: inviter, regionLevel: regionLevel)
		
		DDHTTPRequest.upLoadImages(r: r, requestSuccess: { (responds) in
			
			let jsonRequest = JSON.init(responds);
			BFunction.shared.showSuccessMessage(jsonRequest["message"].stringValue);
			
			successBlock();
			
		}, requestError: { (responds, ErrorModel) in
			
			let jsonRequest = JSON.init(responds);
			let code = jsonRequest["code"].intValue
			var message:String?
			switch code {
			case 101:
				message = "请登录"
			case 102:
				message = "上传出错"
			case 103:
				message = "图片格式不正确"
			case 108:
				message = "请求超时"
			case 110:
				message = "签名不正确"
			case 111:
				message = " 未知错误"
			default:
				message = " Error"
			}
			
			//BFunction.shared.showErrorMessage(message!);
			BFunction.shared.showToastMessge(jsonRequest["message"].stringValue)
		}) { (error) in
			
		}
		
//		DDHTTPRequest.request(r: r, requestSuccess: { (responds) in
//			let json = JSON.init(responds);
//
//			BFunction.shared.showToastMessge(json["message"].stringValue);
//			successBlock()
//		}, requestError: { (responds, ErrorModel) in
//			BFunction.shared.showToastMessge(ErrorModel.message);
//		}) { (error) in
//
//		}
	}
	
}
