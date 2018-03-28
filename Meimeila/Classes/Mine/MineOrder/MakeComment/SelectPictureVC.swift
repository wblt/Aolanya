//
//  SelectPictureVC.swift
//  Mythsbears
//
//  Created by macos on 2017/10/28.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

@objc protocol SelectPictureVCDelegate{
    
    func picSelectType(type:Int)
    
}

class SelectPictureVC: DDBaseViewController {

    weak var delegate:SelectPictureVCDelegate?
    
    @IBOutlet weak var btBGView: UIView!
    
    @IBOutlet weak var cancleBt: UIButton!
    
    
    @IBAction func cameraBtAction(_ sender: Any) {

        delegate?.picSelectType(type: 0)
        
        self.view.removeFromSuperview();
    }
    
    @IBAction func libraryBtAction(_ sender: Any) {
        delegate?.picSelectType(type: 1)
        self.view.removeFromSuperview();
    }
    
    
    @IBAction func cancleBtAction(_ sender: Any) {
        self.view.removeFromSuperview();

    }
    
    
    @IBAction func BGBtAction(_ sender: Any) {

        self.view.removeFromSuperview();
    
    }
    
    
    // 如果不写这个方法，iOS8会崩溃
    init() {
        super.init(nibName: String.init(describing:String.init(describing: SelectPictureVC.self)), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "选择";
        // Do any additional setup after loading the view.
    }

    override func setupUI() {
        btBGView.layer.cornerRadius = 5.0;
        cancleBt.layer.cornerRadius = 5.0;
         self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    
    
    
}


