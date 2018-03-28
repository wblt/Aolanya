//
//  DDXAxisStyle.swift
//  ChartDemo
//
//  Created by HJQ on 2017/9/27.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import Charts

class DDXAxisStyle {

    /*
     * X轴相关
     */
    // x 轴的宽度
    var xaxisLineWidth: CGFloat = 0.5
    // 坐标轴的颜色
    var axisLineColor: UIColor = UIColor.black
    // 是否强制绘制label个数
    var forceLabelsEnabled: Bool = false
    // 坐标文字大小
    var xlabelFont: UIFont = UIFont.systemFont(ofSize: 12)
    // 坐标文字颜色
    var xlabelTextColor: UIColor = UIColor.black
    // 是否需要绘制网格线
    var xdrawGridLinesEnabled: Bool = false
    // 设置偏离y轴的距离
    var xspaceMin: Double = 2
    // x的最大刻度
    var xaxisMaximum: Double = 21
    // 设置x轴的坐标值
    var xvalueFormatter: IAxisValueFormatter?
    // 显示刻度数
    var xlabelCount: Int = 7

}
