//
//  CALayer-Extension.swift
//  Mythsbears
//
//  Created by HJQ on 2017/9/21.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import Foundation
import UIKit

extension CALayer {
    
    // 暂停
    func pauseAnimate() {
        let pausedTime = self.convertTime(CACurrentMediaTime(), from: nil)
        speed = 0
        timeOffset = pausedTime
    }
    
    // 恢复
    func resumeAnimate() {
        let pausedTime: CFTimeInterval = timeOffset
        speed = 1
        timeOffset = 0
        beginTime = 0
        let timeSincePause = self.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        beginTime = timeSincePause
        
    }

}
