//
//  MMLSystemMessageListVC.swift
//  Meimeila
//
//  Created by HJQ on 2017/11/28.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLSystemMessageListVC: DDBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    // 如果不写这个方法，iOS8会崩溃
    init() {
        super.init(nibName: String.init(describing: MMLSystemMessageListVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "系统消息"
        viewBindEvents()
        requestData()
    }
    
    override func setupUI() {
        setupTableView()
    }
    
    // MARK: - Private method
    
    private func viewBindEvents() {
        setupRefresh(tableView, headerCallback: {[weak self] in
            self?.requestData()
            self?.systemMessageViewModel.numberPages = 0
        }) {[weak self] in
            self?.requestData()
            self?.systemMessageViewModel.numberPages += 15
        }
    }
    
    private func requestData() {
        systemMessageViewModel.getSystemMessageList {[weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        tableView.tableFooterView = UIView.init()
        tableView.separatorColor = DDGlobalBGColor()
        tableView.separatorInset.left = 0
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(UINib.init(nibName: String.init(describing: MMLSystemMessageListCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: MMLSystemMessageListCell.self))
    }
    
    private lazy var systemMessageViewModel: MMLSystemMessageListViewModel = {
        let vm = MMLSystemMessageListViewModel()
        vm.tableView = self.tableView
        return vm
    }()

}

// MARK: - UITableViewDataSource
extension MMLSystemMessageListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = tableView.mj_footer {
            tableView.mj_footer.isHidden = systemMessageViewModel.datas.isEmpty
        }
        return systemMessageViewModel.datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: MMLSystemMessageListCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: MMLSystemMessageListCell.self)) as? MMLSystemMessageListCell
        if let _ = cell {}
        else {
            cell = Bundle.main.loadNibNamed(String.init(describing: MMLSystemMessageListCell.self), owner: nil, options: nil)?.first as? MMLSystemMessageListCell
        }
        cell?.data = systemMessageViewModel.datas[indexPath.row]
        return cell!
    }
    
}

// MARK: - UITableViewDelegate
extension MMLSystemMessageListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let VC = MMLSystemMessageDetailVC()
        VC.data = systemMessageViewModel.datas[indexPath.row]
        navigationController?.pushViewController(VC, animated: true)
        
    }
}
