//
//  MMLEditeInfoVC.swift
//  Meimeila
//
//  Created by macos on 2017/10/23.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

@objc protocol MMLEditeInfoVCDelegate{
    
    func editiFinish(indexPath:IndexPath,message:String);
}

class MMLEditeInfoVC: DDBaseViewController {

    @IBOutlet weak var editTF: UITextField!
    
    @IBOutlet weak var enterBt: UIButton!
    @IBAction func enterBtAction(_ sender: Any) {
        delegate?.editiFinish(indexPath: self.indexPath!, message: self.editTF.text ?? "未设置")
		self.navigationController?.popViewController(animated: true);
    }
    
    //iOS8用到XIB必须写这两个方法
    init() {
        super.init(nibName: String.init(describing: MMLEditeInfoVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    var indexPath:IndexPath?
    weak var delegate:MMLEditeInfoVCDelegate?
}
