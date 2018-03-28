//
//  CycleView.swift
//  Draw
//
//  Created by macos on 2017/12/5.
//  Copyright © 2017年 macos. All rights reserved.
//

import UIKit

class CycleView: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white;

    }
    
    func  addCycle(percent:String,starPoint:CGFloat,endPoint:CGFloat,strokeColor:UIColor = UIColor.lightGray,fillColor:UIColor = UIColor.clear) {
        
        drawCycle(starPoint: 0, endPoint: 1, strokeColor: UIColor.init(r: 204, g: 235, b: 217), fillColor: fillColor);

        drawCycle(starPoint: starPoint, endPoint: endPoint, strokeColor: strokeColor, fillColor: fillColor);
        
        addPercent(percent: percent);
    }
    
    
  fileprivate  func drawCycle(starPoint:CGFloat,endPoint:CGFloat,strokeColor:UIColor,fillColor:UIColor ) {
        
        let beziers = UIBezierPath.init();
        beziers.addArc(withCenter: CGPoint.init(x: self.frame.size.width/2, y: self.frame.size.height/2), radius: self.bounds.width/2 - 10, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        
        let shaperLayers = CAShapeLayer.init();
        
        shaperLayers.strokeColor = strokeColor.cgColor
        shaperLayers.fillColor = fillColor.cgColor
        
        shaperLayers.lineWidth = 10.0;
        shaperLayers.strokeStart = starPoint;
        shaperLayers.strokeEnd = endPoint;
        shaperLayers.path = beziers.cgPath;
        shaperLayers.lineCap = kCALineCapRound;
        self.layer.addSublayer(shaperLayers);
    }
    
    
 fileprivate   func addPercent(percent:String) {
        let title = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: 20));
        title.text = "\(percent)%";
        title.font = UIFont.systemFont(ofSize: 20);
        title.textColor = UIColor.black;
        title.backgroundColor = UIColor.clear;
        title.center = self.center;
        title.textAlignment = .center;
        addSubview(title);
    }
    
}
