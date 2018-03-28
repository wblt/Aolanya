//
//  MMLWithdrawalRecordVC.swift
//  Meimeila
//
//  Created by HJQ on 2017/10/23.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLWithdrawalRecordVC: DDBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    // 如果不写这个方法，iOS8会崩溃
    init() {
        super.init(nibName: String.init(describing: MMLWithdrawalRecordVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewBindEvents()
        requestWithdrawRecordData()

    }
    
    override func setupUI() {
        setupTableView()
    }
    
    // MARK: - Private methods
    private func setupTableView() {
        tableView.backgroundColor = DDGlobalBGColor()
        tableView.tableFooterView = UIView.init()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: String.init(describing: MMLWithdrawalRecordCell.self), bundle: nil), forCellReuseIdentifier:  String.init(describing: MMLWithdrawalRecordCell.self))
    }
    
    private func viewBindEvents() {
        setupRefresh(tableView, isNeedFooterRefresh: false, headerCallback: {[weak self] in
            self?.requestWithdrawRecordData()
        }) {
            
        }
    }
    
    // 获取提现记录
    private func requestWithdrawRecordData() {
        withdrawViewModel.getWithdrawRecord {[weak self] in
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - Lazy load
    private lazy var withdrawViewModel: MMLWithdrawViewModel = {[weak self] in
        let vm = MMLWithdrawViewModel()
        vm.tableView = self?.tableView
        return vm
    }()
}

// MARK: - UITableViewDataSource
extension MMLWithdrawalRecordVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return withdrawViewModel.recordModel?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: MMLWithdrawalRecordCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: MMLWithdrawalRecordCell.self)) as? MMLWithdrawalRecordCell
        if let _ = cell {
        }else {
            cell = Bundle.main.loadNibNamed(String.init(describing: MMLWithdrawalRecordCell.self), owner: nil, options: nil)?.first as? MMLWithdrawalRecordCell
        }
        cell?.separatorInset.left = 0
        cell?.data = withdrawViewModel.recordModel?.data[indexPath.row]
        return cell!
    }
    
}

// MARK: - UITableViewDelegate
extension MMLWithdrawalRecordVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
