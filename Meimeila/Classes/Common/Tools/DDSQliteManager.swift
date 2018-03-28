//
//  DDSQliteManager.swift
//  Mythsbears
//
//  Created by HJQ on 2017/10/11.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SQLite3

class DDSQliteManager {

    // 单例
    static let shared = DDSQliteManager()
    private init() {}
    
    // 数据库对象
    private var db: OpaquePointer? = nil
    
    // 创建一个串行队列
    private let dbQueue = DispatchQueue.init(label: "dbQueue")
    
    // 在队列中操作数据库
    func execQueueSQL(action: @escaping (_ manager: DDSQliteManager) -> ()) {
        // 开启一个子线程
        dbQueue.async() {
            action(self)
        }
    }
    
    // 打开数据库
    func openDB(dbName: String) -> Bool {
        let path = dbName.docDir()
        print(path)
        let cPath = path.cString(using: String.Encoding.utf8)!
        // 1.打开数据库
        /*
         1.需要打开的数据库文件的路径, C语言字符串
         2.打开之后的数据库对象 (指针), 以后所有的数据库操作, 都必须要拿到这个指针才能进行相关操作
         */
        // open方法特点: 如果指定路径对应的数据库文件已经存在, 就会直接打开
        //              如果指定路径对应的数据库文件不存在, 就会创建一个新的
        if sqlite3_open(cPath, &db) != SQLITE_OK {
            print("打开数据库失败")
            return false
        }
        return true
    }
    
    
    /// 创建数据库表
    ///
    /// - Parameter sql: sql语句
    /// - Returns: bool 是否创建成功
    private func creatTable(sql: String) -> Bool {
        // 1.编写SQL语句
        // 建议: 在开发中编写SQL语句, 如果语句过长, 不要写在一行
        // 开发技巧: 在做数据库开发时, 如果遇到错误, 可以先将SQL打印出来, 拷贝到PC工具中验证之后再进行调试
//        let sql = "CREATE TABLE IF NOT EXISTS T_Person( \n" +
//            "id INTEGER PRIMARY KEY AUTOINCREMENT, \n" +
//            "name TEXT, \n" +
//            "age INTEGER \n" +
//        "); \n"
        //        print(sql)
        // 2.执行SQL语句
        return execSQL(sql: sql)
    }
    
    /**
     执行除查询以外的SQL语句
     :param: sql 需要执行的SQL语句
     :returns: 是否执行成功 true执行成功 false执行失败
     */
    func execSQL(sql: String) -> Bool {
        // 0.将Swift字符串转换为C语言字符串
        let cSQL = sql.cString(using: String.Encoding.utf8)!
        
        // 在SQLite3中, 除了查询意外(创建/删除/新增/更新)都使用同一个函数
        /*
         1. 已经打开的数据库对象
         2. 需要执行的SQL语句, C语言字符串
         3. 执行SQL语句之后的回调, 一般传nil
         4. 是第三个参数的第一个参数, 一般传nil
         5. 错误信息, 一般传nil
         */
        if sqlite3_exec(db, cSQL, nil, nil, nil) != SQLITE_OK {
            return false
        }
        return true
    }
    
    /**
     查询所有的数据
     :returns: 查询到的字典数组
     */
    func execRecordSQL(sql: String) ->[[String: AnyObject]] {
        // 0.将Swift字符串转换为C语言字符串
        let cSQL = sql.cString(using: String.Encoding.utf8)!
        
        // 1.准备数据
        // 准备: 理解为预编译SQL语句, 检测里面是否有错误等等, 它可以提供性能
        /*
         1.已经开打的数据库对象
         2.需要执行的SQL语句
         3.需要执行的SQL语句的长度, 传入-1系统自动计算
         4.预编译之后的句柄, 已经要想取出数据, 就需要这个句柄
         5. 一般传nil
         */
        var stmt: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, cSQL, -1, &stmt, nil) != SQLITE_OK {
            print("准备失败")
        }
        
        // 准备成功
        var records = [[String: AnyObject]]()
        
        // 2.查询数据
        // sqlite3_step代表取出一条数据, 如果取到了数据就会返回SQLITE_ROW
        while sqlite3_step(stmt) == SQLITE_ROW {
            // 获取一条记录的数据
            let record = recordWithStmt(stmt: stmt!)
            // 将当前获取到的这一条记录添加到数组中
            records.append(record)
        }
        
        // 返回查询到的数据
        return records
    }
    

}

extension DDSQliteManager {
   
    /**
     获取一条记录的值
     :param: stmt 预编译好的SQL语句
     :returns: 字典
     */
    private func recordWithStmt(stmt: OpaquePointer) ->[String: AnyObject] {
        // 2.1拿到当前这条数据所有的列
        let count = sqlite3_column_count(stmt)
        // print(count)
        // 定义字典存储查询到的数据
        var record  = [String: AnyObject]()
        
        for index in 0..<count
        {
            // 2.2拿到每一列的名称
            let cName = sqlite3_column_name(stmt, index)
            let name = String.init(cString: cName!, encoding: String.Encoding.utf8)
            //                print(name)
            // 2.3拿到每一列的类型 SQLITE_INTEGER
            let type = sqlite3_column_type(stmt, index)
            //  print("name = \(name) , type = \(type)")
            
            switch type
            {
            case SQLITE_INTEGER:
                // 整形
                let num = sqlite3_column_int64(stmt, index)
                record[name!] = Int(num) as AnyObject
            case SQLITE_FLOAT:
                // 浮点型
                let double = sqlite3_column_double(stmt, index)
                record[name!] = Double(double) as AnyObject
            case SQLITE3_TEXT:
                // 文本类型
                let cText = UnsafePointer(sqlite3_column_text(stmt, index))
                
                let text = String.init(cString: cText!)
                record[name!] = text as AnyObject
            case SQLITE_NULL:
                // 空类型
                record[name!] = NSNull()
            default:
                // 二进制类型 SQLITE_BLOB
                // 一般情况下, 不会往数据库中存储二进制数据
                print("")
            }
        }
        return record
    }
    
}
