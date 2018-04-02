//
//  MMLWithdrawChildVC.swift
//  Meimeila
//
//  Created by HJQ on 2017/10/23.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import FDStackView

class MMLWithdrawChildVC: DDBaseViewController {
	
	@IBOutlet weak var payStackView: FDStackView!
	// 支付方式
    @IBOutlet weak var payMethodButton: UIButton!
    @IBOutlet weak var payMethodView: UIView!
    
    // 支付宝账号和姓名
    @IBOutlet weak var aliPayAcountView: UIView!
    @IBOutlet weak var aliPayNameView: UIView!
    @IBOutlet weak var aliPayAcountTF: UITextField!
    @IBOutlet weak var aliPayNameTF: UITextField!
    
    // 提现金额
    @IBOutlet weak var amountView: UIView!
    @IBOutlet weak var amountLabel: UILabel!
    
    private var type: Int = 0 // 0 是支付宝
    private var moneyAmount: Double = 0
    
    // 如果不写这个方法，iOS8会崩溃
    init() {
        super.init(nibName: String.init(describing: MMLWithdrawChildVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewBindEvents()
    }
    
    override func setupUI() {
        //aliPayAcountView.isHidden = true
        //aliPayNameView.isHidden = true
    }
    
    // MARK: - Private method
    private func viewBindEvents() {
        // 选择支付方式
        let selectedPaymethodTapGes = UITapGestureRecognizer.init(target: self, action: #selector(selectedPaymethodAction))
        payMethodView.addGestureRecognizer(selectedPaymethodTapGes)
        
        // 选择提现金额
        let moneyTapGes = UITapGestureRecognizer.init(target: self, action: #selector(selectedWithDrawAmountAction))
        amountView.addGestureRecognizer(moneyTapGes)
    }
    
    // 提现
    private func requestWithdrawData() {
        view.endEditing(false)
        // 提现金额
        let money = Double(amountLabel.text!)
        let account = aliPayAcountTF.text!.trimmingCharacters(in: .whitespaces)
        let name = aliPayNameTF.text!.trimmingCharacters(in: .whitespaces)
        
        if type == 0 { // 支付宝提现
            if account.count == 0 {
                BFunction.shared.showToastMessge("请输入支付宝账号")
                return
            }
            if name.count == 0 {
                BFunction.shared.showToastMessge("请输入姓名")
                return
            }
        }

        
        withdrawViewModel.withdraw(type: type, money: money!, alipay: account, realName: name) {
        }
    }

    
    // MARK: - Event respose
    // 选择支付方式
    @objc func selectedPaymethodAction() {
        let VC = MMLWithdrawalwayVC()
        VC.delegate = self
        VC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        present(VC, animated: false, completion: nil)
    }
    
    // 选择提现金额
    @objc func selectedWithDrawAmountAction() {
        let VC = MMLWithdrawalamountVC()
        VC.deleagete = self
        VC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        present(VC, animated: false, completion: nil)
    }
    
    // 确认提现
    @IBAction func sureWithdrawAction(_ sender: Any) {
        requestWithdrawData()
    }
    
    // MARK: - Lazy load
    private lazy var withdrawViewModel: MMLWithdrawViewModel = {
        let vm = MMLWithdrawViewModel()
        return vm
    }()
}

// 选择提现金额
// MARK: - MMLWithdrawalamountVCDelegate
extension MMLWithdrawChildVC: MMLWithdrawalamountVCDelegate {
    func withdrawalamount(amount: Double) {
        amountLabel.text = "\(amount)"
    }
}

// 选择支付方式
// MARK: - MMLWithdrawalwayVCDelegate
extension MMLWithdrawChildVC: MMLWithdrawalwayVCDelegate {
    func withdrawalway(type: Int) {
        if type == 0 { // 支付宝提现
            self.type = 0
            aliPayAcountView.isHidden = false
            aliPayNameView.isHidden = false
			payStackView.insertArrangedSubview(aliPayAcountView, at: 1)
			payStackView.insertArrangedSubview(aliPayNameView, at: 2)
            payMethodButton.setTitle("支付宝", for: .normal)
        }else { // 微信红包提现
            self.type = 1
            aliPayAcountView.isHidden = true
            aliPayNameView.isHidden = true
			payStackView.removeArrangedSubview(aliPayAcountView)
			payStackView.removeArrangedSubview(aliPayNameView)
			
            payMethodButton.setTitle("微信", for: .normal)
        }
    }
}
