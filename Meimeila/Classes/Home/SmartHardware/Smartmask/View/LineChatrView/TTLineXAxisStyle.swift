//
//  TTLineXAxisStyle.swift
//  Mythsbears
//
//  Created by macos on 2017/11/8.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import Charts
class TTLineXAxisStyle{

    ///不绘制网格线
    var drawGridLinesEnabled = false;
    
    ///网格线颜色
    var axisLineColor = DDGlobalNavBarColor();
  
    ///间隔
    var granularity = 1;
    
    ///label,X轴的显示位置，默认是显示在上面的
    var labelPosition = XAxis.LabelPosition.bottom;
    
    ///线宽
    var axisLineWidth = 1.0
    
    ///label间隔
    var spaceBetweenLabels = 4.0;
    
    ///字体颜色
    var labelTextColor = UIColor.lightGray;
    
    ///最大显示数据量
    var maxVisibleCount = 999;
    
    ///重复值不显示
    var granularityEnabled = true;
    
    
    
}
