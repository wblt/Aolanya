//
//  SmartmaskSQManger.swift
//  Mythsbears
//
//  Created by macos on 2017/10/26.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class SmartmaskSQManger {

    static var shared = SmartmaskSQManger()
    let SQ = DDSQliteManager.shared;
    
    func creatSQ() {
        
        if  SQ.openDB(dbName: "Smartmask.sql") {
            
            print("打开数据库成功！")
            
            //建表
            
            let sql = "CREATE TABLE IF NOT EXISTS T_Person( \n" +
                "id INTEGER PRIMARY KEY AUTOINCREMENT, \n" +
                "name TEXT, \n" +
                "age INTEGER \n" +
            ") \n"
            
            print(sql);
            
            if  SQ.execSQL(sql: sql) {
                
                print("建表/打开成功")
            }
        }
        
        
    }
    
    ///添加
    func SQ_add() {
        
        let sql = "INSERT INTO T_Person(name,age) VALUES"
            + "("
            + "'\(1111)'"
            + ","
            + "\(2222)"
            + ")"
        
        print(sql);
        
        if SQ.execSQL(sql: sql) {
            
            print("插入成功!")
        }
        
    }
    
    ///删除数据
    func SQ_delete() {
        
        let sql = "delete from T_Person where name = '魅族-MX417'"
        print(sql);
        
        if SQ.execSQL(sql: sql) {
            
            print("删除成功")
        }
    }
    
    
    ///查数据
    func SQ_readOne() {
        
        //条件查询
        let sql = "SELECT age , name from T_Person where age = 56"
        
        //全部查询
        //        let sql = "SELECT * from T_Person"
        
        print(sql);
        
        let dateArr = SQ.execRecordSQL(sql: sql)
        
        if !dateArr.isEmpty {
            
            print("查询成功")
            
            let model = dateArr[0];
            print(model)
        }
    }
    
    
    ///更新数据
    func SQ_upDateUserInfo() {
        
        let sql = "update T_Person set name = '魅族X' where name = '魅族-MX469'"
        print(sql);
        
        if SQ.execSQL(sql: sql) {
            
            print("更新成功")
        }
    }
    
}


