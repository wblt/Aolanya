//
//  MMLSearchVC.swift
//  Meimeila
//
//  Created by HJQ on 2017/10/18.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLSearchVC: DDBaseViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var clearView: UIView!
    
    init() {
        super.init(nibName: String.init(describing: MMLSearchVC.self), bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        baseViewWillAppearSetNavBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        baseViewWillDisappearSetNavBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewBindEvents()
        view.backgroundColor = DDGlobalBGColor()
        requestHotSearchKeywords()
        historyView.datas = readHistoryKeyWordToLocal()
    }
    
    override func setupUI() {
        setupNavBar()
        setupTableView()
    }
    
    // MARK: - Private methods
    // 设置导航栏
    private func setupNavBar() {
        
        navigationItem.titleView = searchTextField
        addNavBarBackButton(imageName: "btn_back") { [weak self](btn) in
            self?.navigationController?.popViewController(animated: true)
        }
        
        addNavBarRightButton(btnTitle: "搜索", titleColor: UIColor.lightGray) { [weak self](btn) in
            if  self?.searchTextField.text!.trimmingCharacters(in: .whitespaces).count != 0 {
                self?.saveHistoryKeyWordToLocal(keyWord: (self?.searchTextField.text!)!)
                self?.historyView.datas = (self?.readHistoryKeyWordToLocal())!
                // 不重新设置位置不正常
                self?.tableView.tableFooterView = self?.historyView
                self?.view.endEditing(false)
                self?.searchTextField.resignFirstResponder()
                let vc = MMLProductListVC()
                vc.keyWord = (self?.searchTextField.text!)!
                self?.navigationController?.pushViewController(vc, animated: true)
            }else {
                BFunction.shared.showToastMessge("请输入不为空的关键字")
            }
        }
    }
    
    private func setupTableView() {
        tableView.separatorStyle = .none
        tableView.tableHeaderView = self.hotView
        tableView.tableFooterView = self.historyView
        tableView.backgroundColor = DDGlobalBGColor()
    }
    
    private func viewBindEvents() {
        let tagGes = UITapGestureRecognizer.init(target: self, action: #selector(clearLocalHistorySearchAction))
        clearView.addGestureRecognizer(tagGes)
    }
    
    // 获取热搜数据
    private func requestHotSearchKeywords() {
        hotSearchViewModel.getHotSearchKeywords {[weak self] in
            var hotKeywords = [String]()
            if let tempHotKeywords = self?.hotSearchViewModel.hotSearchKeywords?.hot {
                tempHotKeywords.forEach({ (data) in
                    hotKeywords.append(data.keyword)
                })
            }
            self?.hotView.datas = hotKeywords
            self?.tableView.tableHeaderView = self?.hotView
        }
    }
    
    // 保存历史搜索关键字
    private func saveHistoryKeyWordToLocal(keyWord: String) {
        var datas = readHistoryKeyWordToLocal()
        // 去重复
        for (index, value) in datas.enumerated() {
            if value == keyWord {
                datas.remove(at: index)
            }
        }
        
        if datas.count >= 9 {
            datas.removeLast()
        }
        datas.insert(keyWord, at: 0)
        UserDefaults.standard.set(datas, forKey: "historySearch")
    }
    
    // 读取本地的历史记录
    private func readHistoryKeyWordToLocal() -> [String]{
        return UserDefaults.standard.value(forKey: "historySearch") as? [String] ?? [String]()
    }
    
    // MARK: - Event respose
    // 清除本地搜索历史
    @objc func clearLocalHistorySearchAction() {
        debugLog("清空搜索历史")
        UserDefaults.standard.set([], forKey: "historySearch")
        UserDefaults.standard.synchronize()
        historyView.datas = []
        tableView.tableFooterView = historyView
    }
    
    // MARK: - lazy load
    private lazy var hotView: DDMallSearchHotView = {
        let view = DDMallSearchHotView.init()
        view.delegate = self
        return view
    }()
    
    private lazy var historyView: DDMallSearchHistoryView = {
        let view = DDMallSearchHistoryView.init()
        view.delegate = self
        return view
    }()
    
    // TODO: 宽度需要按比例
    private lazy var searchTextField: UITextField = {
        let width = Screen.width * 250 / 375
        let leftImageView = UIImageView.init(image: UIImage.init(named: "mall_search"))
        leftImageView.contentMode = .center
        leftImageView.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        let textField = DDMallSearchTextField.init(leftView: leftImageView, frame: CGRect.init(x: 0, y: 0, width: width, height: 30), color: nil, boardWidth: 0, boardRadius: 15)
        textField.backgroundColor = DDGlobalBGColor()
        textField.placeholder = "搜索商品"
        textField.returnKeyType = .search
        textField.delegate = self
        return textField
    }()
    
    private lazy var hotSearchViewModel: MMLSearchViewModel = {
        let vm = MMLSearchViewModel()
        return vm
    }()
    

    
}

// MARK: - 热搜点击代理
extension MMLSearchVC: DDMallSearchHotViewDlegate {
    func hotItemSelected(text: String) {
        // 商品列表
        let vc = MMLProductListVC()
        vc.keyWord = text
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - 历史搜索点击代理
extension MMLSearchVC: DDMallSearchHistoryViewDlegate {
    func historyItemSelected(text: String) {
        let vc = MMLProductListVC()
        vc.keyWord = text
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension MMLSearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if  self.searchTextField.text!.trimmingCharacters(in: .whitespaces).count != 0 {
            self.saveHistoryKeyWordToLocal(keyWord: (self.searchTextField.text!))
            self.historyView.datas = (self.readHistoryKeyWordToLocal())
            // 不重新设置位置不正常
            self.tableView.tableFooterView = self.historyView
            self.view.endEditing(false)
            self.searchTextField.resignFirstResponder()
            let vc = MMLProductListVC()
            vc.keyWord = (self.searchTextField.text!)
            self.navigationController?.pushViewController(vc, animated: true)
        }else {
            BFunction.shared.showToastMessge("请输入不为空的关键字")
        }
        return true
    }
}
