//
//  ALYMessageDetailsVC.swift
//  Meimeila
//
//  Created by wy on 2018/4/19.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import UIKit

class ALYMessageDetailsVC: DDBaseViewController {
    @IBOutlet weak var titleLab: UILabel!
    
    @IBOutlet weak var timeLab: UILabel!
    
    @IBOutlet weak var contentLab: UILabel!
    
    var model:MineMessageModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "我的消息"
        titleLab.text = model?.msgTitle
        timeLab.text = model?.msgAddTime
        contentLab.text = model?.msgBody
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
