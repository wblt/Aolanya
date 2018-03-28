//
//  DDAddDeletedLineLabel.swift
//  Mythsbears
//
//  Created by HJQ on 2017/9/25.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

// 设置文本会要调用sizeToFit方法
class DDAddDeletedLineLabel: UILabel {

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        textColor.set()
        let width = rect.size.width
        let height = rect.size.height
        UIRectFill(CGRect.init(x: 0.0, y: height * 0.35, width: width, height: 1.0))
    }


}
