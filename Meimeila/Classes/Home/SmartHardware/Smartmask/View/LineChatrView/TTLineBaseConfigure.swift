//
//  TTLineBaseConfigure.swift
//  Mythsbears
//
//  Created by macos on 2017/11/8.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class TTLineBaseConfigure{

    ///背景颜色
    var backGroundColor = UIColor.white;
    
    ///描述文字
    var descriptionText = "";
    
    ///无数据时文字提示
    var noDataText = "暂无数据";
    
    ///不显示图例说明
    var legendEnable = false;
    
    ///取消X轴缩放
    var x_scaleEnable = false;
    
    ///取消Y轴缩放
    var y_scaleEnable = false;
    
    ///取消缩放
    var scaleEnabled = false;
    
    ///取消双击缩放
    var doubleTapToZoomEnabled = false;
    
    ///取消拖拽惯性动画
    var dragDecelerationEnabled = false;
    
    ///惯性摩擦系数(0~1),数值越小,惯性效果越明显
    var dragDecelerationFrictionCoef:Float = 0.0;
}
