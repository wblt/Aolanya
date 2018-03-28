//
//  MMLMusicSQManger.swift
//  Meimeila
//
//  Created by macos on 2017/11/29.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLMusicSQManger: NSObject {
    static var shared = MMLMusicSQManger()
    let SQ = DDSQliteManager.shared;
    
    func creatSQ() {
        
        if  SQ.openDB(dbName: "MUSICSQ.sql") {
            
            print("打开数据库成功！")
            
            //建表
            
            let sql = "CREATE TABLE IF NOT EXISTS MUSIC( \n" +
                "id INTEGER PRIMARY KEY AUTOINCREMENT, \n" +
                "songdata TEXT,\n" +
                "url TEXT,\n" +
                "filePath TEXT" +
                ") \n"
            
            print(sql);
            
            if  SQ.execSQL(sql: sql) {
                
                print("建表/打开成功")
            }else{
                
                print("建表/打开失败")
                
            }
        }
        
        
    }
    
    ///添加
    func SQ_add(songdata:String,url:String,filePath:String,succeeds:()->(),falses:()->()) {
        
        let sql = "INSERT INTO MUSIC(songdata,filePath,url) VALUES"
            + "("
            + "'\(songdata)'"
            + ","
            + "'\(filePath)'"
            + ","
            + "'\(url)'"
            + ")"
        
        print(sql);
        
        if SQ.execSQL(sql: sql) {
            
            print("插入成功!")
            succeeds();
        }else{
            
            falses()
            
        }
        
    }
    
    ///删除数据
    func SQ_delete(url:String,succeeds:()->(),fales:()->()) {
        
        let sql = "delete from MUSIC where url = '\(url)'"
        print(sql);
        
        if SQ.execSQL(sql: sql) {
            
            print("删除成功")
            succeeds();
        }else{
            fales();
        }
    }
    
    
    ///条件查数据
    func SQ_readOne(url:String) -> Bool {
        
        //条件查询
        let sql = "SELECT url from MUSIC where url = '\(url)'"
        
        //全部查询
        //let sql = "SELECT * from T_Person"
        
        print(sql);
        
        let dateArr = SQ.execRecordSQL(sql: sql)
        
        if dateArr.isEmpty {
            
            return false;
        }
        
        return true;
    }
    
    
    ///查所有数据
    func SQ_readALL() ->[JQDownLoadVoiceModel]{
        
        //条件查询
        //let sql = "SELECT ID from MUSIC where ID = \(ID)"
        
        //全部查询
        let sql = "SELECT * from MUSIC"
        
        print(sql);
        
        let dateArr = SQ.execRecordSQL(sql: sql)
        var arr = [JQDownLoadVoiceModel]()
        if !dateArr.isEmpty {
            print("查询成功");
            dateArr.forEach({ (item) in
                
                let model = JQDownLoadVoiceModel.init();
                model.downloadUrl = item["url"] as! String;
                model.name = item["songdata"] as! String;
                model.filePath = item["filePath"] as! String;
                arr.append(model);
            })
            
        }
        return arr;
    }
    
    
    ///更新数据
    func SQ_upDateUserInfo(songdata:String,url:String, succeeds:()->()) {
        
        let sql = "update MUSIC set url = '\(url)' , where songdata = '\(songdata)'"
        print(sql);
        
        if SQ.execSQL(sql: sql) {
            
            print("更新成功")
            
            succeeds()
        }
    }
    
}

