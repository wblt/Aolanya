//
//  DDLimitLineStyle.swift
//  ChartDemo
//
//  Created by HJQ on 2017/9/27.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import Foundation
import Charts

// 限制线的基本样式
class DDLimitLineStyle {

    var y: Double = 80
    // 文本
    var text: String = ""
    // 文本颜色
    var textColor: UIColor = UIColor.red
    // 字体
    var font: UIFont = UIFont.systemFont(ofSize: 11)
    // 线条宽度
    var lineWidth: CGFloat = 1.0
    // 线条颜色
    var lineColor: UIColor = UIColor.red
    // 必须有一个不为0的数
    var lineDashLengths: [CGFloat] = [1.0, 0]
    // 文本显示的位置
    var labelPosition: ChartLimitLine.LabelPosition = ChartLimitLine.LabelPosition(rawValue: LabelPosition.rightTop.rawValue)!
    

}
