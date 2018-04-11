//
//  ALYAgentApplyVC.swift
//  Meimeila
//
//  Created by wy on 2018/4/11.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import UIKit

class ALYAgentApplyVC: DDBaseViewController {

    init() {
        super.init(nibName: String.init(describing: ALYAgentApplyVC.self), bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我要赚钱"
        // Do any additional setup after loading the view.
    }

    @IBAction func firstBtnClick(_ sender: Any) {
        let vc = ALYAgentMsgInputVC()
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func secondBtnClick(_ sender: Any) {
        let vc = ALYAgentMsgInputVC()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func thridBtnClick(_ sender: Any) {
        let vc = ALYAgentViewController()
        
        navigationController?.pushViewController(vc, animated: true)
        
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
