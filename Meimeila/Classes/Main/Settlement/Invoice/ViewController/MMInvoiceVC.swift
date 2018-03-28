//
//  MMInvoiceVC.swift
//  Meimeila
//
//  Created by HJQ on 2017/10/20.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

@objc protocol MMInvoiceVCDelegate {
    // 发票信息
    func invoiceSave(text: String,json:String)
}




class MMInvoiceVC: DDBaseViewController {

    
    @IBOutlet weak var paperInvoice: UIButton!
    
    
    @IBOutlet weak var electronicInvoic: UIButton!
    
    
    @IBAction func papaerInvoiceBt(_ sender: Any) {
        
        paperInvoice.isSelected = true;
        electronicInvoic.isSelected = false;
        
        invoiceTF.text = "个人"
        invoiceType = "纸质发票";
        invoiceTitle = invoiceTF.text ?? "个人"

    }
    
    
    
    @IBAction func electronicBtAction(_ sender: Any) {
        
        paperInvoice.isSelected = false;
        electronicInvoic.isSelected = true;
        invoiceTF.text = "非个人"
        invoiceType = "电子发票"
        invoiceTitle = invoiceTF.text ?? "非个人"
    }
    
    weak var delegate: MMInvoiceVCDelegate?
    @IBOutlet weak var invoiceTF: UITextField!
    
    init() {
        super.init(nibName: String.init(describing: MMInvoiceVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "发票信息"
        
        paperInvoice.isSelected = true;
    }
    
    override func setupUI() {
        setupNavBar()
    }
    
    // MARK: - Private methods
    private func setupNavBar() {
        addNavBarRightButton(btnTitle: "保存", titleColor: UIColor.white) { [weak self](btn) in
            if let _ = self?.delegate {
//                self?.delegate?.invoiceSave(text: (self?.invoiceTF.text!.trimmingCharacters(in: .whitespaces))!)
           
                self?.delegate?.invoiceSave(text:(self?.invoiceTitle)! , json: (self?.jsonString())!);
            }
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    
    var invoiceType = "纸质发票";
    var invoiceTitle = "个人";
    
    ///转json字符串
    func jsonString() -> String{
        var dic = [String:String]()
        dic["invoiceTitle"] = invoiceTitle;
        dic["invoiceType"] = invoiceType;
        
        let data = try? JSONSerialization.data(withJSONObject: dic, options: JSONSerialization.WritingOptions.init(rawValue: 0));
        let js = String.init(data: data!, encoding: String.Encoding.utf8)
        
        print("invoice json string--->>>>",js!);
        return js!;
    }
    
    
    
}
