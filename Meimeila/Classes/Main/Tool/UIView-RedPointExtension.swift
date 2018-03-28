//
//  UIView-RedPointExtension.swift
//  Mythsbears
//
//  Created by HJQ on 2017/9/21.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    // UIView 添加数字上标
    func showRedpointOffset(x: CGFloat, y: CGFloat, value: String?) {
        removeRedpoint()
        
        let badgeView = UIView.init()
        badgeView.isUserInteractionEnabled = false
        badgeView.tag = 999888
        
        var viewWidth = 12
        if let _ = value {
            viewWidth = 15
            let valueLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: viewWidth, height: viewWidth))
            valueLabel.text = value
            valueLabel.font = UIFont.systemFont(ofSize: 10)
            valueLabel.textColor = UIColor.white
            valueLabel.textAlignment = .center
            valueLabel.clipsToBounds = true
            badgeView.addSubview(valueLabel)
        }
        
        badgeView.layer.cornerRadius = CGFloat(viewWidth / 2)
        badgeView.backgroundColor = UIColor.red
        
        badgeView.frame = CGRect.init(x: x, y: y, width: CGFloat(viewWidth), height: CGFloat(viewWidth))
        addSubview(badgeView)
        
        // 添加动画
        let pulse = CABasicAnimation(keyPath: "transform.scale")
        pulse.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        pulse.duration = 0.8
        pulse.repeatCount = MAXFLOAT
        pulse.autoreverses = true
        pulse.fromValue = Float(0.9)
        pulse.toValue = Float(1.1)
        pulse.isRemovedOnCompletion = false
        badgeView.layer.add(pulse, forKey: nil)
        badgeView.layer.pauseAnimate()
    }
    
    // 移除
    func removeRedpoint() {
        for view in subviews {
            if view.tag == 999888 {
                view.removeFromSuperview()
            }
        }
    }
    
    // 恢复动画
    func resumeAnimate() {
        for view in subviews {
            if view.tag == 999888 {
                view.layer.resumeAnimate()
                return
            }
        }
    }
    
}
