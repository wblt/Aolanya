//
//  DDBarChartDataSetStyle.swift
//  ChartDemo
//
//  Created by HJQ on 2017/9/27.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class DDBarChartDataSetStyle {

    // 柱形图边框颜色
    var barBorderColor: UIColor = UIColor.clear
    // 柱形图边框大小
    var barBorderWidth: CGFloat = 0
    //是否在柱形图上面显示数值
    var drawValuesEnabled: Bool = true
    //点击选中柱形图是否有高亮效果，（双击空白处取消选中）
    var highlightEnabled: Bool = false
    var highlightAlpha: CGFloat = 0.5
    // 透明度
    var setAlpha: CGFloat = 1

}
