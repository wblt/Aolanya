//
//  JQMusicLrcModel.swift
//  AudioPlayerDemo
//
//  Created by HJQ on 2017/11/20.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class JQMusicLrcModel: NSObject {
    
    var time: TimeInterval = 0
    var title: String = ""
    
    //  将特定的歌词格式进行转换
    class func musicLrcWithString(contentStr: String) -> JQMusicLrcModel{
        let model = JQMusicLrcModel()
        let lrcLines = contentStr.components(separatedBy: "]")
        if lrcLines.count == 2 {
            model.title = lrcLines[1]
            var timeString = lrcLines.first
            timeString = timeString?.replacingOccurrences(of: "[", with: "")
            timeString = timeString?.replacingOccurrences(of: "]", with: "")
            let times = timeString?.components(separatedBy: ":")
            if times?.count == 2 {
                let time = Int((times?.first)!)! * 60 + Int((times?.last)!)!
                model.time = TimeInterval(time)
            }
        }else if lrcLines.count == 1 {
            
        }
        return model
        
    }
    
    // 根据歌词的路径返回歌词模型数组
    class func musicLRCModelsWithLrcFileName(name: String) -> [JQMusicLrcModel]{
        let lrcPath = Bundle.main.path(forResource: name, ofType: nil)
        do {
            let lrcString = try String.init(contentsOf: URL(string: lrcPath!)!, encoding: String.Encoding.utf8)
            let lrcLines = lrcString.components(separatedBy: "\n")
            
            var lrcModels = [JQMusicLrcModel]()
            for (_, value) in lrcLines.enumerated() {
                if value.hasPrefix("[ti") ||  value.hasPrefix("[ar") || value.hasPrefix("[al") || value.hasPrefix("[") {
                    continue
                }
                let lrcModel = JQMusicLrcModel.musicLrcWithString(contentStr: value)
                lrcModels.append(lrcModel)
            }
            return lrcModels
        }
        catch {
            print(error)
        }
  
        return [JQMusicLrcModel]()
    }

}
