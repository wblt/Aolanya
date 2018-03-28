//
//  MMLWithdrawalamountVC.swift
//  Meimeila
//
//  Created by HJQ on 2017/10/23.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

@objc protocol MMLWithdrawalamountVCDelegate {
    func withdrawalamount(amount: Double)
}

class MMLWithdrawalamountVC: UIViewController {

    weak var deleagete: MMLWithdrawalamountVCDelegate?
    
    @IBOutlet weak var pickerView: UIPickerView!
    private var amountStr: String = ""
    
    // 如果不写这个方法，iOS8会崩溃
    init() {
        super.init(nibName: String.init(describing: MMLWithdrawalamountVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPickerView()
        amountStr = datas.first!
    }
    
    // MARK: - Private method
    private func setupPickerView() {
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    // MARK: - Event respse
    @IBAction func cancelButtonAction(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func sureButtonAction(_ sender: Any) {
        if let _ = deleagete {
            deleagete?.withdrawalamount(amount: Double(amountStr)!)
        }
        dismiss(animated: false, completion: nil)

    }
    
    // MARK: - Lazy load
    private lazy var datas: [String] = {
        let array = ["30", "50", "70", "80", "100", "200", "300"]
        return array
    }()
    
}

// MARK: - UIPickerViewDelegate
extension MMLWithdrawalamountVC: UIPickerViewDelegate {
    
    // 当前选中那一行
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(row)
        amountStr = datas[row]
    }
}

// MARK: - UIPickerViewDataSource
extension MMLWithdrawalamountVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // 有多少行
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return datas.count
    }
    
    // 行高
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    // 每一行标题
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return datas[row] + "元"
    }
    
    
}
