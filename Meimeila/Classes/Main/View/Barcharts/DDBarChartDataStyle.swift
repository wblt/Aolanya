//
//  DDBarChartDataStyle.swift
//  ChartDemo
//
//  Created by HJQ on 2017/9/27.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import Charts

class DDBarChartDataStyle {

    // 不在bar上显示数值
    var isDrawValues: Bool = false
    //文字字体
    var valueFont: UIFont = UIFont.systemFont(ofSize: 14)
    //文字颜色
    var valueTextColor: UIColor = UIColor.clear
    //自定义数据显示格式
    var valueFormatter: IValueFormatter?
    

}
