//
//  MMLUseHelp.swift
//  Meimeila
//
//  Created by macos on 2017/11/28.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLUseHelp: DDBaseWebViewVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    var html:String?
    
    override func viewWillAppear(_ animated: Bool) {
        
        if  let _ = html {
            
            loadLocalFileName(html!);
        }
    }
}
