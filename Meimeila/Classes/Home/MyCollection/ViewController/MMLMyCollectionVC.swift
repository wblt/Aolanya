//
//  MMLMyCollectionVC.swift
//  Meimeila
//
//  Created by HJQ on 2017/10/19.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLMyCollectionVC: DDBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "我的收藏"
        viewBindEvents()
        requestCollectionData()

    }
    
    override func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Private methods
    private func viewBindEvents() {
        setupRefresh(tableView, isNeedFooterRefresh: false, headerCallback: { [weak self] in
            self?.myCollectionViewModel.numberPages = 0
            self?.requestCollectionData()
        }) {[weak self] in
            self?.myCollectionViewModel.numberPages += 15
            self?.requestCollectionData()
        }
    }
    
    // 获取收藏列表
    private func requestCollectionData() {
        myCollectionViewModel.getMyCollectionList {[weak self] in
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - Lazy load
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView.tableFooterView = UIView.init()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: String.init(describing: MMLMyCollectionListCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: MMLMyCollectionListCell.self))
        return tableView
    }()
    
    private lazy var myCollectionViewModel: MMLMyCollectionViewModel = {[weak self] in
        let vm = MMLMyCollectionViewModel()
        vm.tableView = self?.tableView
        return vm
    }()



}

// MARK: - UITableViewDataSource
extension MMLMyCollectionVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.displayprompts(message: "暂无收藏商品~", image: "my_collect_empty", cellCount: myCollectionViewModel.myCollectionList.count)
        if let _ = tableView.mj_footer {
            tableView.mj_footer.isHidden = myCollectionViewModel.myCollectionList.isEmpty
        }
        return myCollectionViewModel.myCollectionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: MMLMyCollectionListCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: MMLMyCollectionListCell.self)) as? MMLMyCollectionListCell
        if let _ = cell {
        }else {
            cell = Bundle.main.loadNibNamed(String.init(describing: MMLMyCollectionListCell.self), owner: nil, options: nil)?.first as? MMLMyCollectionListCell
        }
        cell?.data = myCollectionViewModel.myCollectionList[indexPath.row]
        return cell!
    }
    
}

// MARK: - UITableViewDelegate
extension MMLMyCollectionVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let VC = MMLProductDetailsVC()
        VC.shoppingID = myCollectionViewModel.myCollectionList[indexPath.row].shopingID
        navigationController?.pushViewController(VC, animated: true)
    }
}
