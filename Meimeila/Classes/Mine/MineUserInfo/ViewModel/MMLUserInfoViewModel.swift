//
//  MMLUserInfoViewModel.swift
//  Meimeila
//
//  Created by macos on 2017/10/23.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON
import MJRefresh

class MMLUserInfoViewModel{

    var userInfoCellTitleArr = [[""],
                                ["账号"],
                                ["昵称","性别","所在地","个性签名"],
                                ["职业","年龄","邮箱","手机号"]
                                ];
    
    var userInfoCellDetailArr = [[String]]()
    var cellCurrentDetail:UILabel?
    var tableView:UITableView?
    var userInfoArr:[String]?
    var currentVC:DDBaseViewController?
    var infoModel:UserInfoModel?
    
    //获取会员等级
    func getUserMemberLv(succeeds:@escaping(_ lv:String) -> Void) {
        let r = UserInfoAPI.userMemberLv
        DDHTTPRequest.request(r: r, requestSuccess: { (responds) in
            let json = JSON.init(responds);
            let lv = json["data"].stringValue;
            succeeds(lv);
            
        }, requestError: { (responds, ErrorModel) in
            //            let json = JSON.init(responds);
            
            
        }) { (error) in
            
        }
    }
    
    //获取用户信息
    func getUserInfo(succeeds:@escaping () -> Void) {
        
        let r = UserInfoAPI.userInfo
        
        DDHTTPRequest.request(r: r, requestSuccess: { (responds) in
            
            let jsonResult = JSON.init(responds);
           
            print(jsonResult);

            self.userInfoCellDetailArr.removeAll();

            var sectionZero = [String]();
            var sectionOne = [String]();
            var sectionTwo = [String]();
            var sectionThree = [String]();
            
            let userModel =  UserInfoModel.init(formJson: jsonResult["data"])
            
            self.infoModel = userModel;
            
            var iconUrl = userModel.picture ?? "0";
            
            if !iconUrl.hasPrefix("http"){
                
                iconUrl = kPrefixLink + iconUrl;
                self.infoModel?.picture = iconUrl;
            }
            print(iconUrl);
            sectionZero.append(iconUrl);
            sectionOne.append(userModel.uid ?? "未设置");
            sectionTwo.append(userModel.name ?? "未设置");
            sectionTwo.append(userModel.gender ?? "未设置");
            sectionTwo.append(userModel.address ?? "未设置");
            sectionTwo.append(userModel.personalizedSignature ?? "未设置");
            sectionThree.append(userModel.occupation ?? "未设置");
            sectionThree.append(userModel.birth ?? "未设置");
            sectionThree.append(userModel.email ?? "未设置");
            sectionThree.append(userModel.phone ?? "未设置");
            
            self.userInfoCellDetailArr.append(sectionZero);
            self.userInfoCellDetailArr.append(sectionOne);
            self.userInfoCellDetailArr.append(sectionTwo);
            self.userInfoCellDetailArr.append(sectionThree);
            
            if ((self.tableView?.mj_header) != nil) {
                
                self.tableView?.mj_header.endRefreshing();

            }
            
            succeeds()
            
        }, requestError: { (responds, ErrorModel) in
            
            
            if ((self.tableView?.mj_header) != nil) {
                
                self.tableView?.mj_header.endRefreshing();
                
            }
        }) { (error) in
            
            if ((self.tableView?.mj_header) != nil) {
                
                self.tableView?.mj_header.endRefreshing();
                
            }
        }
        
    }
    
    
    //上传用户信息
    func userInfoUp(name: String?, sex: String?, age: String?, email: String?, qq: String?, address: String?, personalizedSignature: String?, occupation: String?) {
    
        let r = UserInfoAPI.userInfoUpData(name: name, sex: sex, age: age, email: email, qq: qq, address: address, personalizedSignature: personalizedSignature, occupation: occupation)
        DDHTTPRequest.request(r: r, requestSuccess: { (responds) in
            let json = JSON.init(responds);
            BFunction.shared.showToastMessge(json["message"].stringValue);
            
        }, requestError: { (responds, ErrorModel) in
            BFunction.shared.showToastMessge(ErrorModel.message);
            
            
        }) { (error) in
            
        }
        
    }
    
    
    
    
    
    //上传图片
    func uploadImage(_ iconImage:UIImage,succeeds:@escaping () -> Void) {
        
        BFunction.shared.showLoading();
        
        let r = UserInfoAPI.userIconUpload(image: iconImage);
        
        DDHTTPRequest.upLoadImages(r: r, requestSuccess: { (responds) in
            
            let jsonRequest = JSON.init(responds);
            BFunction.shared.showSuccessMessage(jsonRequest["message"].stringValue);
            
            succeeds();
            
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
            
            BFunction.shared.showErrorMessage(message!);
            
        }) { (error) in
            
        }
    }
    
}


//extension MMLUserInfoViewModel:SelectPicProtocol{
//    func selectPicType(_ type: Int) {
//
//        if type == 2 {
//
//            DDPhotoLibraryManager.shared.browseFromCamera();
//
//        }else if type == 1{
//
//            DDPhotoLibraryManager.shared.browseFromLibrary();
//        }
//    }
//
//}

