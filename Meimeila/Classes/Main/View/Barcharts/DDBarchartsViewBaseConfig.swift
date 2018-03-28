//
//  DDBarchartsViewBaseConfig.swift
//  ChartDemo
//
//  Created by HJQ on 2017/9/27.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class DDBarchartsViewBaseConfig: UIView {

    // 隐藏描述文字不显示，就设为空字符串即可
    var chartDescriptionText: String = ""
    // 不显示图例说明
    var legend: Bool = false
    
    // 没有数据显示的文字
    var noDataText: String = "没有相关数据"
    // 数值显示在柱形的上面还是下面
    var drawValueAboveBarEnabled: Bool = true
    //是否绘制柱形的阴影背景
    var drawBarShadowEnabled: Bool = false
    /// 交互设置
    // 取消Y轴缩放
    var scaleYEnabled: Bool = false
    // 取消双击缩放
    var doubleTapToZoomEnabled: Bool = false
    // 启用拖拽图表
    var dragDecelerationEnabled: Bool = true
    //拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
    var dragDecelerationFrictionCoef: CGFloat = 0.9
}
