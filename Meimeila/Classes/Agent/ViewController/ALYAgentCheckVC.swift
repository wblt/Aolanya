//
//  ALYAgentCheckVC.swift
//  Meimeila
//
//  Created by yanghuan on 2018/4/8.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import UIKit

class ALYAgentCheckVC: DDBaseViewController {

	
	@IBOutlet weak var lab1: UILabel!
	@IBOutlet weak var lab2: UILabel!
	@IBOutlet weak var lab3: UILabel!
	@IBOutlet weak var lab4: UILabel!
	@IBOutlet weak var img1: UIImageView!
	@IBOutlet weak var img2: UIImageView!
	@IBOutlet weak var img3: UIImageView!
	@IBOutlet weak var img4: UIImageView!
	@IBOutlet weak var line1: UIView!
	@IBOutlet weak var line3: UIView!
	
	//iOS8用到XIB必须写这两个方法
	init() {
		super.init(nibName: String.init(describing: ALYAgentCheckVC.self), bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

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
