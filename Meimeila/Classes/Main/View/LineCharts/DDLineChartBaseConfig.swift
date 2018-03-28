//
//  DDLineChartBaseConfig.swift
//  ChartDemo
//
//  Created by HJQ on 2017/10/30.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

// 基本配置
class DDLineChartBaseConfig {

    // 没有数据提示信息
    var noDataFont = UIFont.systemFont(ofSize: 13)
    var noDataTextColor = UIColor.black
    var noDataText = "没有相关数据！"
    
    // 图例说明
    var chartDescriptionEnabled = false
    var chartDescriptionText = "图例说明"
    var chartDescriptionFont = UIFont.systemFont(ofSize: 13)
    var chartDescriptionTextColor = UIColor.red
    var chartDescriptionTextAlign = NSTextAlignment.center
    var legendEnabled = false
    
    // 取消x或y轴缩放
    var scaleXEnabled = false
    var scaleYEnabled = false
    
    // 是否启用拖拽
    var dragEnabled = true
    // 拖拽后的惯性效果
    var dragDecelerationEnabled = true
    // 摩擦系数
    var dragDecelerationFrictionCoef: CGFloat = 0.9
    
    // x轴的动画时间
    var xAnimationTime = 0.25
    
}
