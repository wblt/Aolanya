//
//  MineMessageModel.swift
//  Mythsbears
//
//  Created by macos on 2017/11/7.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON

class MineMessageModel{

//    "msgID": "1",    //消息id
//    "uid": "10021",   //用户ID
//    "msgTitle": "这是测试标题一",   //消息标题
//    "msgBody": "测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试",   //消息内容
//    "msgAddTime": "1479016816",  //发布时间
//    "msgPublisher": "小宁",   //发布作者
//    "msgType": "2"   //消息类型
    
    
    var msgID:String?
    var uid:String?
    var msgTitle:String?
    var msgBody:String?
    var msgAddTime:String?
    var msgPublisher:String?
    var msgType:String?
    
    init(from json:JSON) {
        msgID = json["msgID"].stringValue;
        uid = json["uid"].stringValue;
        msgTitle = json["msgTitle"].stringValue;
        msgBody = json["msgBody"].stringValue;
        msgAddTime = json["msgAddTime"].stringValue;
        msgPublisher = json["msgPublisher"].stringValue;
        msgType = json["msgType"].stringValue;
        
    }
    
}
