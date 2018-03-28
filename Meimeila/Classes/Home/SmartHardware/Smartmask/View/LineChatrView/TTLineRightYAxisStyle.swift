//
//  TTLineRightYAxisStyle.swift
//  Mythsbears
//
//  Created by macos on 2017/11/8.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import Charts
class TTLineRightYAxisStyle {

    ///不绘制右边轴信息
    var rightAxisEnabled = false;
    
    ///Y轴label数量，数值不一定，如果forceLabelsEnabled等于YES
    var labelCount = 5;
    
    ///不强制绘制指定数量的label
    var forceLabelsEnabled = false
    
    ///不显示最大值和最小值
    var showOnlyMinMaxEnabled = false
    
    ///y轴最小值
    var axisMinValue = 0
    
    ///y轴最大值
    var axisMaxValue = 100
    
    ///从0开使绘制
    var startAtZeroEnabled = true
    
    ///不将y轴进行上下翻转
    var inverted = false
    
    ///y轴线宽
    var axisLineWidth = 1
    
    ///y轴颜色
    var axisLineColor = UIColor.orange
    
    ///label位置
    var labelPosition = YAxis.LabelPosition.outsideChart;
    
    ///文字颜色
    var labelTextColor = UIColor.lightGray
    
    //文字字体大小
    var labelFont = UIFont.systemFont(ofSize: 16);
    
    ///网格虚线样式
    var gridLineDashLengths = [3.0, 3.0]
    
    ///网格线颜色
    var gridColor = UIColor.green
   
    ///网格线开启抗锯齿
    var gridAntialiasEnabled = true
    
}
