//
//  MMLWithdrawalwayVC.swift
//  Meimeila
//
//  Created by HJQ on 2017/10/23.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit


@objc protocol MMLWithdrawalwayVCDelegate {
    func withdrawalway(type: Int)
}

class MMLWithdrawalwayVC: UIViewController {

    weak var delegate: MMLWithdrawalwayVCDelegate?
    
    @IBOutlet weak var alipayView: UIView!
    @IBOutlet weak var wechatPayView: UIView!
    
    
    // 如果不写这个方法，iOS8会崩溃
    init() {
        super.init(nibName: String.init(describing: MMLWithdrawalwayVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewBindEvents()

    }
    
    // MARK: - Private method
    private func viewBindEvents() {
        let aliPayTapGes = UITapGestureRecognizer.init(target: self, action: #selector(selectedPayMethodAction(tap:)))
        alipayView.addGestureRecognizer(aliPayTapGes)
        
        let wechatTapGes = UITapGestureRecognizer.init(target: self, action: #selector(selectedPayMethodAction(tap:)))
        wechatPayView.tag = 1
        wechatPayView.addGestureRecognizer(wechatTapGes)
    }

    // MARK: - Event respose
    @objc func selectedPayMethodAction(tap: UITapGestureRecognizer) {
        let tag = (tap.view?.tag)!
        if tag == 0 { // 支付宝提现
            
        }else { // 微信提现
            
        }
        if let _ = delegate {
            delegate?.withdrawalway(type: tag)
        }
        dismiss(animated: false, completion: nil)
    }
    
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    

}
