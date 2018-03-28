//
//  TakePictureCell.swift
//  Mythsbears
//
//  Created by macos on 2017/10/28.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class TakePictureCell: UICollectionViewCell {

    
    
    @IBOutlet weak var BGView: UIView!
    
    
    @IBOutlet weak var containImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

}

extension TakePictureCell{
    
    func addRectDashBorder() {


        let layer = CALayer.init();
        let shapeLayer = CAShapeLayer.init();
        let beizier = UIBezierPath.init(rect: BGView.bounds);
        shapeLayer.frame = BGView.bounds;
        shapeLayer.fillColor = UIColor.clear.cgColor;
        shapeLayer.strokeColor = UIColor.lightGray.cgColor;
        shapeLayer.lineDashPattern = [NSNumber.init(value: 10),NSNumber.init(value: 10)];
        shapeLayer.path = beizier.cgPath;
        layer.addSublayer(shapeLayer);
        
        BGView.layer.addSublayer(layer);
    }
}
