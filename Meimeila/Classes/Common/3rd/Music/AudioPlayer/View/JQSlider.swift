//
//  JQSlider.swift
//  AudioPlayerDemo
//
//  Created by HJQ on 2017/11/20.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

private let kProgressHeight: CGFloat = 2
private let kProgressLeftPadding: CGFloat = 2
// 滑块
private let kThumbHeight: CGFloat = 16

class JQSlider: UIControl {

    // 提供给外部使用的属性
//    var progressColor: UIColor!
//    var progressCacheColor: UIColor!
//    var thumbColor: UIColor!
    
    // 值 0 - 1
    var value: CGFloat = 0 {
        didSet {
            if isTouch {return}
            
            // 关闭隐式动画
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            
            let x = kThumbHeight/2.0 + value * (self.frame.width - kThumbHeight)
            let y = self.frame.height / 2.0
            self.thumbLayer.position = CGPoint.init(x: x, y: y)
            self.progressCacheLayer.frame.size.width = value * (self.frame.width - kThumbHeight)
            
            CATransaction.commit()
        }
    }
    // 值 0 - 1
    //var cacheValue: CGFloat = 0
    
    // 内部属性
    private var isTouch: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        adjustLayout()
    }
    
    // MARK: - Private methods
    private func setupUI() {
        self.layer.addSublayer(self.progressLayer)
        self.layer.addSublayer(self.progressCacheLayer)
        self.layer.addSublayer(self.thumbLayer)
    }
    
    // 调整布局
    private func adjustLayout() {
        if  progressLayer.frame == CGRect.zero || thumbLayer.frame == CGRect.zero {
            let x = kProgressLeftPadding
            let y = (self.frame.height - kProgressHeight) / 2.0
            let w = self.frame.width - 2 * kProgressLeftPadding
            
            progressLayer.frame = CGRect.init(x: x, y: y, width: w, height: kProgressHeight)
            progressCacheLayer.frame = CGRect.init(x: x, y: y, width: 0, height: kProgressHeight)
            thumbLayer.frame = CGRect.init(x: 0.0, y: 0.0, width: kThumbHeight, height: kThumbHeight)
            thumbLayer.position = CGPoint.init(x: kThumbHeight/2.0, y: self.layer.frame.size.height/2.0)
        }
    }
    

    // MARK: - Lazy load
    private lazy var thumbLayer: CALayer = {
        let layer = CALayer.init()
        // 使用图片平铺的方式
        layer.backgroundColor = UIColor(patternImage: UIImage(named:"mvplayer_progress_thumb_mini")!).cgColor
        return layer
    }()
    
    private lazy var progressLayer: CALayer = {
        let layer = CALayer.init()
        // 使用图片平铺的方式
        layer.backgroundColor = UIColor(patternImage: UIImage(named:"mvplayer_progress_bg_mini")!).cgColor
        return layer
    }()
    
    private lazy var progressCacheLayer: CALayer = {
        let layer = CALayer.init()
        // 使用图片平铺的方式
        layer.backgroundColor = UIColor(patternImage: UIImage(named:"mvplayer_progress_played_mini")!).cgColor
        return layer
    }()
}

// MARK: - touch
extension JQSlider {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        isTouch = true
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        isTouch = false
        //进行类  型转化
        let touch = ((touches as NSSet).anyObject() as AnyObject).location(in: self)
        var x = touch.x
        if touch.x < kThumbHeight/2.0 {
            x = kThumbHeight/2.0
        }else if touch.x > (self.frame.width - kThumbHeight/2.0) {
            x = (self.frame.width - kThumbHeight/2.0)
        }
        // 关闭隐式动画
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        self.thumbLayer.position = CGPoint.init(x: x, y: self.frame.height/2.0)
        self.progressCacheLayer.frame.size.width = x - self.progressCacheLayer.frame.origin.x
        CATransaction.commit()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        isTouch = false
        let touch = ((touches as NSSet).anyObject() as AnyObject).location(in: self)
        var x = touch.x
        if touch.x <= kThumbHeight/2.0 {
            x = kThumbHeight/2.0
        }else if touch.x >= (self.frame.width - kThumbHeight/2.0) {
            x = (self.frame.width - kThumbHeight/2.0)
        }
        self.value = 1.0*(x-kThumbHeight/2.0) / (self.frame.width - kThumbHeight)
        for target in self.allTargets {
            let actions = self.actions(forTarget: target, forControlEvent: UIControlEvents.valueChanged)
            for acion in actions! {
                self.sendAction(Selector.init(acion), to: target, for: event)
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        isTouch = false
    }
}
