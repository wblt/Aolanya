//
//  DDXAxisValueFormatter.swift
//  ChartDemo
//
//  Created by HJQ on 2017/9/27.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import Charts

class DDXAxisValueFormatter: NSObject, IAxisValueFormatter {

    var xAxisDatas: [String]!
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        // 倍率
        let ratio = Double((axis?.axisMaximum)!) / Double((axis?.labelCount)!)
        // 获取到下标
        let index = Int(Double(value) / ratio)
        if index >= xAxisDatas.count || index < 0 { // 越界判断
            return ""
        }
        return xAxisDatas[index]
    }
    
}
