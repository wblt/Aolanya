//
//  APPVersionVC.swift
//  Mythsbears
//
//  Created by macos on 2017/11/16.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class APPVersionVC: DDBaseViewController {

    @IBOutlet weak var icon: UIImageView!
   
    @IBOutlet weak var currentVision: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func setupUI() {
        self.title = "版本信息"
        currentVision.text = "当前版本:\(vm.version)";
        
        
        
        vm.appStoreVersion();
        
    }
    
    // 如果不写这个方法，iOS8会崩溃
    init() {
        super.init(nibName: String.init(describing:String.init(describing: APPVersionVC.self)), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var vm:MSXVersionViewModel = {
        
        let vm = MSXVersionViewModel.shared;
        return vm;
    }()
}
