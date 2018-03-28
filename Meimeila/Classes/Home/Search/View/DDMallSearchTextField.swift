//
//  DDMallSearchTextField.swift
//  Mythsbears
//
//  Created by HJQ on 2017/9/20.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class DDMallSearchTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience  init(leftView: UIView?, frame: CGRect, color: UIColor?, boardWidth: CGFloat, boardRadius : CGFloat)
    {
        self.init(frame:frame)
        var tempColor = color
        leftViewMode = UITextFieldViewMode.always
        self.leftView = leftView
        if tempColor == nil
        {
            //默认一个颜色
            tempColor = DDGlobalBGColor()
        }
        self.layer.borderColor = color?.cgColor
        //边框宽度
        self.layer.borderWidth = boardWidth
        self.layer.masksToBounds = true
        self.clearButtonMode = .whileEditing
        //边框圆角
        self.layer.cornerRadius = boardRadius
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
