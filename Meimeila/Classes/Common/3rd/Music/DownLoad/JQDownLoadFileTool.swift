//
//  JQDownLoadFileTool.swift
//  AudioPlayerDemo
//
//  Created by HJQ on 2017/11/23.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class JQDownLoadFileTool: NSObject {
    
    // 查看本地文件是否存在
    class func isFileExists(path: String) -> Bool {
        return FileManager.default.fileExists(atPath: path)
    }
    
    // 文件大小
    class func fileSizeWithPath(path: String) -> UInt64 {
        // 检测文件是否存在
        if !isFileExists(path: path) {
            return 0
        }
        
        do {
            let fileDict = try FileManager.default.attributesOfItem(atPath: path)
            return (fileDict[FileAttributeKey.size] as! UInt64)
        } catch  {
            print(error)
        }
        return 0
    }
    
    // 文件移动
    class func moveFile(fromPath: String, toPath: String) {
        if !isFileExists(path: fromPath) {
            return
        }
        do {
            try FileManager.default.moveItem(atPath: fromPath, toPath: toPath)
        } catch  {
            print(error)
        }
        
    }
    
    // 文件移除
    class func removeFileAtPath(path: String) {
        if !isFileExists(path: path) {
            return
        }
        do {
            try FileManager.default.removeItem(atPath: path)
        } catch  {
            print(error)
        }
    }
}
