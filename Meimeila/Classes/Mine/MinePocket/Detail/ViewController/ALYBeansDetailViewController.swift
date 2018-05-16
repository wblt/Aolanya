//
//  ALYBeansDetailViewController.swift
//  Meimeila
//
//  Created by yanghuan on 2018/5/16.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import UIKit

class ALYBeansDetailViewController: DDBaseViewController {
	
	var model:MMLBeansDetailModel?
	
	@IBOutlet weak var beansNunLab: UILabel!
	
	@IBOutlet weak var typeLab: UILabel!
	
	@IBOutlet weak var timeLab: UILabel!
	
	@IBOutlet weak var totalNumLab: UILabel!
	
	

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.navigationItem.title = "明细"
		
		beansNunLab.text = "+" + (model?.beans)!
		
		if  model?.remarks == "3" {
			typeLab.text = "分享"
		} else if  model?.remarks == "2"{
			typeLab.text = "健康豆兑换"
		}
		
		timeLab.text = model?.addtime?.replacingOccurrences(of: ".0", with: "")
		totalNumLab.text = model?.banlance
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
