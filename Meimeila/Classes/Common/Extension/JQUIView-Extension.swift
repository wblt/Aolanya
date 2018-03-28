//
//  UIView-Extension.swift
//  YSBRXSwift
//
//  Created by HJQ on 2017/6/17.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import Foundation
import UIKit


extension UIView {
    
    //缩放动画
    func jq_viewAddScaleAnimation() {
        //需要实现的帧动画，这里根据需求自定义
        let animation: CAKeyframeAnimation = CAKeyframeAnimation.init()
        animation.keyPath = "transform.scale";
        animation.values = [1.0,1.3,0.9,1.15,0.95,1.02,1.0];
        animation.duration = 1;
        animation.calculationMode = kCAAnimationCubic
        self.layer.add(animation, forKey: "")
    }
    
    // 缩放
    func jq_viewAddScaleXYAnimation() {
    
        let animation: CABasicAnimation = CABasicAnimation.init(keyPath: "transform.scale")
        // 速度控制函数，控制动画的节奏
        animation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut)
        animation.duration = 0.3
        animation.repeatCount = 1
        animation.isRemovedOnCompletion = true
        animation.fillMode = kCAFillModeForwards
        animation.fromValue = NSNumber.init(value: 0.7)
        animation.toValue = NSNumber.init(value: 1.3)
        self.layer.add(animation, forKey: "")
    }
    
    // 放大动画 没有还原
    func jq_viewAddScaleSAnimation() {
        let animation: CABasicAnimation = CABasicAnimation.init(keyPath: "transform.scale")
        // 速度控制函数，控制动画的节奏
        animation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut)
        animation.duration = 0.2
        animation.repeatCount = 1
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        animation.fromValue = NSNumber.init(value: 1.0)
        animation.toValue = NSNumber.init(value: 1.3)
        self.layer.add(animation, forKey: "")
    }
    
    //旋转动画
    func jq_viewAddRotateAnimation() {
        UIView.animate(withDuration: 0.32, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: { 
            self.layer.transform = CATransform3DMakeRotation(CGFloat.pi, 0, 1, 0)
        }) { (_) in
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: {
            UIView.animate(withDuration: 0.32, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                self.layer.transform = CATransform3DMakeRotation(2.0 * CGFloat.pi, 0, 1, 0)
            }) { (_) in
                
            }
        })
    }
    
    
    // y轴移动
    func jq_viewAddMoveYAnimation() {
        let animation: CABasicAnimation = CABasicAnimation.init(keyPath: "transform.translation.y")
        // 速度控制函数，控制动画的节奏
        animation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut)
        animation.duration = 0.2
        animation.repeatCount = 1
        animation.isRemovedOnCompletion = true
        animation.fromValue = NSNumber.init(value: 0)
        animation.toValue = NSNumber.init(value: -10);
        self.layer.add(animation, forKey: "")
    }
    
    // z轴旋转
    func jq_viewAddRotateZAnimation() {
        
        let animation: CABasicAnimation = CABasicAnimation.init(keyPath: "transform.rotation.z")
        // 速度控制函数，控制动画的节奏
        animation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut)
        animation.duration = 0.2
        animation.repeatCount = 1
        animation.isRemovedOnCompletion = true
        animation.fillMode = kCAFillModeForwards
        animation.fromValue = NSNumber.init(value: 0.0)
        animation.toValue = NSNumber.init(value: Double.pi)
        self.layer.add(animation, forKey: "")
    }
    


}
