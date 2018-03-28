//
//  DDRightYAxisStyle.swift
//  ChartDemo
//
//  Created by HJQ on 2017/9/27.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import Charts

class DDRightYAxisStyle {

    /*
     * Y轴相关
     */
    // 是否显示右边的Y轴
    var isShowRightAxis: Bool = true
    // 是否强制绘制
    var forceLabelsEnabled: Bool = true
    // 是否从0开始绘制
    var drawZeroLineEnabled: Bool = true
    // 是否上下翻转
    var inverted: Bool = false
    // y轴显示的刻度数
    var yLabelCount: Int = 10
    // y轴的线宽
    var yAxisLineWidth: CGFloat = 1
    // y轴的颜色
    var yAxisLineColor: UIColor = UIColor.lightGray
    // y轴的最大坐标值
    var yAxisMaximum: Double = 100
    // y轴的最小坐标值
    var yAxisMinimum: Double = 0
    // 网格线和网格颜色
    var ygridLineDashLengths: [CGFloat] = [1.0, 0.0]
    // 网格线宽
    var gridLineWidth: CGFloat = 0.5
    //网格线颜色
    var ygridColor: UIColor = UIColor.init(red: 243.0/255, green: 244.0/255, blue: 245.0/255, alpha: 1)
    
    // 绘制限制线的显示位置 true表示在柱形图的后面
    var yDrawLimitLinesBehindDataEnabled: Bool = true
    //是否绘制网格线
    var YdrawGridLines:Bool = false
}
