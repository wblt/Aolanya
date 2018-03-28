//
//  MMLDrawViewModel.swift
//  Meimeila
//
//  Created by macos on 2017/12/1.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLDrawViewModel{

    static var shared = MMLDrawViewModel.init();
    fileprivate init(){}
    
    var drawColor:UIColor = APPgreenColor ?? UIColor.black;
    var drawFillColor:UIColor = UIColor.clear;
    
    var starPoint = 0.0;
    var endPoint = 1.0;
    
    
    var shaperLayer = CAShapeLayer.init()
    
    var bezier = UIBezierPath.init()
    
    var superView:UIView!
    
}

extension MMLDrawViewModel{
    
    
    func drawCycle() {
        shaperLayer.bounds = CGRect.init(x: 0, y: 0, width: 100, height: 100);
        shaperLayer.position = superView.center;
        
    }
}
