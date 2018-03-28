//
//  DDAlertController.swift
//  Mythsbears
//
//  Created by HJQ on 2017/9/21.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class DDAlertController: UIAlertController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func addAction(_ action: UIAlertAction) {
        super.addAction(action)
        
        // 修改Action的颜色
        if action.style == .default {
            action.setValue(UIColor.init(r: 111, g: 179, b: 243), forKey:"titleTextColor")
            
        }else if  action.style == .cancel {
            action.setValue(UIColor.lightGray, forKey:"titleTextColor")
        }
    }

}
