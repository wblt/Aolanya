//
//  MMLNewsWelfareVC.swift
//  Meimeila
//
//  Created by HJQ on 2017/11/29.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

protocol MMLNewsWelfareVCDelegate: class {
    func newsWelfareVCCloseAction(isNeverShow: Bool)
    func newsWelfareVCReceiveAction(isNeverShow: Bool)
}

class MMLNewsWelfareVC: UIViewController {

    
    @IBOutlet weak var receiveButton: UIButton!
    @IBOutlet weak var checkButton: UIButton!
    
    weak var delegate: MMLNewsWelfareVCDelegate?
    
    
    // 如果不写这个方法，iOS8会崩溃
    init() {
        super.init(nibName: String.init(describing: MMLNewsWelfareVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        receiveButton.layer.cornerRadius = 5.0
    }
    
    // MARK: - Private method
    private func removeAction() {
        view.alpha = 0.5
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 0.0
        }) { (_) in
            self.view.removeFromSuperview()
        }
    }
    
    // MARK: - Event respose
    // 领取红包
    @IBAction func receiveButtonAction(_ sender: Any) {
        if let _ = delegate {
            delegate?.newsWelfareVCReceiveAction(isNeverShow: checkButton.isSelected)
        }
        removeAction()
        
    }
    
    
    @IBAction func closeButtonAction(_ sender: Any) {
        if let _ = delegate {
            delegate?.newsWelfareVCCloseAction(isNeverShow: checkButton.isSelected)
        }
        removeAction()
    }
    
    @IBAction func checkButtonAction(_ sender: Any) {
        checkButton.isSelected = !checkButton.isSelected
    }
    

}
