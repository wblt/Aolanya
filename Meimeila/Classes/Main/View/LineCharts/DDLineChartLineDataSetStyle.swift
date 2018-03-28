//
//  DDLineChartLineDataSetStyle.swift
//  ChartDemo
//
//  Created by HJQ on 2017/10/30.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

// 折线显示的样式配置
class DDLineChartLineDataSetStyle {

    // 设置折线的宽度
    var lineWidth: CGFloat = 1.0
    // 折线的颜色
    var lineColor = DDGlobalNavBarColor()
    
    // 选中当前点的十字线
    var highlightColor = UIColor.clear
    
    // 是否在拐点显示数值
    var drawValuesEnabled = false
    // 拐点样式设置
    
    // 是否设置拐点
    var drawCirclesEnabled = true
    // 内部圆
    var drawCircleHoleEnabled = true
    var circleHoleColor = UIColor.red
    var circleHoleRadius: CGFloat = 3
    // 外部大圆
    var circleColor = UIColor.white
    var circleRadius: CGFloat = 5
    
    // 是否填充颜色
    var drawFilledEnabled = false
}
