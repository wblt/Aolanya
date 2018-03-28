//
//  MMLMusicModel.swift
//  Meimeila
//
//  Created by macos on 2017/11/27.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON
class MMLMusicModel{

//    "id": "1",
//    "name": "庐州月",
//    "singer": "许嵩",
//    "url": "http://fs.open.kugou.com/c405c239141012f4dfe9012b8d521e13/5a042203/G008/M08/09/05/SA0DAFT54y6ABPn5AD4YCjKY_Vo396.mp3",
//    "addtime": "1321"
//
//    "head": null,
//    "songdata": "许嵩 - 玫瑰花的葬礼",
//    "url": "http://fs.open.kugou.com/fb82f41a05f920913ac2e0879197cc27/5a0191e2/G004/M06/04/08/pIYBAFS54SiAMi7PAD8-ejOqpbY010.mp3",
//    "lrc": ""
//
    
    
    var id:String?
    var name:String?
    var singer:String?
    var url:String?
    var addtime:String?
    
    var head:String?
    var songdata:String?
    var lrc:String?
    
    var filePath:String?
    var isPlayNow = false;
    
    init(musicList json:JSON) {
        id = json["id"].stringValue;
        name = json["name"].stringValue;
        singer = json["singer"].stringValue;
        url = json["url"].stringValue;
        addtime = json["addtime"].stringValue;
    }
    
    
    init(musicListen json:JSON) {
        head = json["head"].stringValue;
        url = json["url"].stringValue;
        songdata = json["songdata"].stringValue;
        lrc = json["lrc"].stringValue;
    }
    init(DModel:JQDownLoadVoiceModel) {
        
        url = DModel.downloadUrl;
        name = DModel.name;
        singer = DModel.name;
        songdata = DModel.name;
        
    }
}
