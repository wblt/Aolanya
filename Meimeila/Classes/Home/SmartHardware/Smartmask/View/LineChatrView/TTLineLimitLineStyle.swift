//
//  TTLineLimitLineStyle.swift
//  Mythsbears
//
//  Created by macos on 2017/11/8.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import Charts
class TTLineLimitLineStyle{

    ///线宽
    var lineWidth = 2;
    ///线条颜色
    var lineColor = UIColor.purple
    //虚线样式
    var lineDashLengths = [5.0,5.0];
    ///label显示位置
    var labelPosition = ChartLimitLine.LabelPosition.leftBottom
    //label文字颜色
    var valueTextColor = UIColor.green
    //label字体
    var valueFont = UIFont.systemFont(ofSize: 16)
    //设置限制线绘制在折线图的后面
    var drawLimitLinesBehindDataEnabled = true;
}
