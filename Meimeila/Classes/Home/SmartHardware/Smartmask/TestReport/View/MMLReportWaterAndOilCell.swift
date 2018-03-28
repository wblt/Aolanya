//
//  MMLReportWaterAndOilCell.swift
//  Meimeila
//
//  Created by macos on 2017/11/30.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLReportWaterAndOilCell: UITableViewCell {

    @IBOutlet weak var greenCube: UIView!
    
    @IBOutlet weak var cellTitle: UILabel!
    
    @IBOutlet weak var beforeBGView: UIView!
    
    
    @IBOutlet weak var afterBGView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setCycle(beforePrecent:Int,afterPrecent:Int) {
        
        let w = beforeBGView.frame.size.width;
        let h = beforeBGView.frame.size.height;
        
    
        let before = CycleView.init(frame: CGRect.init(x: 6, y: 6, width: w, height: h));
        
        let after =  CycleView.init(frame: CGRect.init(x: 6, y: 6, width: w, height: h));
        
        print(before.bounds);
        print(after.bounds);
        
        beforeBGView.addSubview(before);
        afterBGView.addSubview(after);
        
        before.addCycle(percent: "\(beforePrecent)", starPoint: 0, endPoint: CGFloat(beforePrecent) * 0.01);
        after.addCycle(percent: "\(afterPrecent)", starPoint: 0, endPoint: CGFloat(afterPrecent) * 0.01);

    }
    
    
    func addCycleLayer() {
        
        let beziers = UIBezierPath.init();
        beziers.addArc(withCenter: CGPoint.init(x: beforeBGView.frame.size.width/2, y: beforeBGView.frame.size.height/2), radius: beforeBGView.bounds.width/2, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        
        let shaperLayers = CAShapeLayer.init();
        
        shaperLayers.strokeColor = UIColor.red.cgColor;
        shaperLayers.fillColor = UIColor.lightGray.cgColor;
        
        shaperLayers.lineWidth = 10.0;
        shaperLayers.strokeStart = 0;
        shaperLayers.strokeEnd = 1;
        shaperLayers.path = beziers.cgPath;
        
        beforeBGView.layer.addSublayer(shaperLayers);
        
    }
}
