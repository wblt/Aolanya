//
//  JQMusicLrcLabel.swift
//  AudioPlayerDemo
//
//  Created by HJQ on 2017/11/20.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import Foundation

class JQMusicLrcLabel: UILabel {

    var progress: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // 重绘
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let fillRect = CGRect.init(x: 0, y: 0, width: frame.size.width * progress, height: frame.height)
        UIColor.red.set()
        UIRectFillUsingBlendMode(fillRect, CGBlendMode.sourceIn)
        
    }

}
