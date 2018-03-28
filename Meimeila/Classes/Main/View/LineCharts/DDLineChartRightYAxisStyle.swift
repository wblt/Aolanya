//
//  DDLineChartRightYAxisStyle.swift
//  ChartDemo
//
//  Created by HJQ on 2017/10/30.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import Charts

// 右边Y轴
class DDLineChartRightYAxisStyle {
    // 不绘制右边轴
    var rightAxisEnable = true
    
    var labelCount = 5
    var forceLabelsEnabled = false
    // 最大最小值
    var axisMinimum: Double = 0.0
    var axisMaximum: Double = 100.0
    
    // 设置x轴的坐标值
    var yvalueFormatter: IAxisValueFormatter?
    
    // 是否将Y轴进行上下翻转
    var inverted = false
    // Y轴颜色
    var axisLineColor = UIColor.black
    // label位置
    var labelPosition: YAxis.LabelPosition = .outsideChart
    // 显示文字的颜色
    var labelTextColor = UIColor.darkGray
    
    // 网格线
    var drawGridLinesEnabled = false
    var gridLineWidth: CGFloat = 0.5
    var gridColor = UIColor.red
    // 开启抗锯齿
    var gridAntialiasEnabled = false
}
