//
//  DDPopAlterVC.swift
//  Mythsbears
//
//  Created by macos on 2017/10/30.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

@objc protocol DDPopAlterVCDelegate{
    
    func dissmissAlterVC()
}

class DDPopAlterVC: UIViewController {

    
    @IBOutlet weak var BGView: UIView!
    @IBOutlet weak var BGButton: UIButton!
    @IBOutlet weak var alterMessageLabel: UILabel!
    @IBOutlet weak var dissmissBt: UIButton!
    
   fileprivate var messages:String!
    weak var delegate:DDPopAlterVCDelegate?
    
    @IBAction func dismissBtAction(_ sender: Any) {
        
        delegate?.dissmissAlterVC();
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        alterMessageLabel.text = messages;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // 如果不写这个方法，iOS8会崩溃
    
    init(message:String){
        super.init(nibName: String.init(describing: DDPopAlterVC.self), bundle: nil)
        
        self.messages = message;
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
