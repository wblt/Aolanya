//
//  DDShareButtonView.swift
//  Mythsbears
//
//  Created by HJQ on 2017/9/21.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit


@objc protocol DDShareButtonViewDelegate {
    func buttonSelectedIndex(index: Int)
}

class DDShareButtonView: UIView {

    // 图片数组
    let images = ["mall_share_wechat", "mall_share_wechatline"]
    // 标题数组
    let titles = ["微信好友","朋友圈"]
    
    weak var delegate: DDShareButtonViewDelegate?
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        
        //let maxCols = 2
        
        let buttonW: CGFloat = 60
        let buttonH: CGFloat = 70
        var buttonStartX: CGFloat = (UIScreen.main.bounds.size.width - 10 - 2 * buttonW) / 2.0
        //20
        //let xMargin: CGFloat = 10
            // (Screen.width - 20 - 2 * buttonStartX - CGFloat(maxCols) * buttonW) / CGFloat(maxCols - 1)
        
        // 创建按钮
        for index in 0..<images.count {
            let button = DDVerticalButton()
            button.tag = index
            button.setImage(UIImage(named: images[index]), for: .normal)
            button.setTitle(titles[index], for: .normal)
            button.setTitleColor(UIColor.lightGray, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            button.width = buttonW
            button.height = buttonH
            button.addTarget(self, action: #selector(shareButtonClick), for: .touchUpInside)
            
            // 计算 X、Y
//            let row = Int(index / maxCols)
//            let col = index % maxCols
//            let buttonX: CGFloat = CGFloat(col) * (xMargin + buttonW) + buttonStartX
//            let buttonMaxY: CGFloat = CGFloat(row) * buttonH
//            let buttonY = buttonMaxY
            button.frame = CGRect(x: buttonStartX, y: 15.0, width: buttonW, height: buttonH)
            addSubview(button)
            
            buttonStartX += 10 + button.width
        }
    }
    
    @objc func shareButtonClick(button: UIButton) {
        if  let _ = delegate {
            delegate?.buttonSelectedIndex(index: button.tag)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
