//
//  DDLineChartXAxisStyle.swift
//  ChartDemo
//
//  Created by HJQ on 2017/10/30.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import Charts

// 设置X轴
class DDLineChartXAxisStyle {

    // 不重复显示数值
    var granularityEnabled = true
    
    // lable显示在底部
    var labelPosition: XAxis.LabelPosition =  XAxis.LabelPosition.bottom
    
    // 设置x轴的坐标值
    var xvalueFormatter: IAxisValueFormatter?
    
    // 网格线
    var gridColor = UIColor.clear
    var gridLineWidth: CGFloat = 0
    
    // 底部显示的标签
    var labelFont = UIFont.systemFont(ofSize: 13)
    var labelTextColor = UIColor.red
    
    // x轴的颜色
    var axisLineColor = UIColor.black
}
