//
//  MMLFoundVC.swift
//  Meimeila
//
//  Created by HJQ on 2017/10/16.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLFoundVC: DDBaseViewController {

    init() {
        super.init(nibName: String.init(describing: MMLFoundVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewBindEvents()
        requestData()
    }
    
    override func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Private method
    
    private func viewBindEvents() {
        setupRefresh(tableView, headerCallback: {[weak self] in
            self?.foundBrandViewModel.numberPages = 0
            self?.requestData()
        }) {[weak self] in
            self?.foundBrandViewModel.numberPages += 15
            self?.requestData()
        }
    }
    
    private func requestData() {
        foundBrandViewModel.getFoundBrandList {[weak self] in
            self?.foundHeaderView.bannerDatas = self?.foundBrandViewModel.foundBrandModel?.banner
        }
    }
    
    // MARK: - Lazy load
    private lazy var tableView: UITableView = {[weak self] in
        let tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView.tableFooterView = UIView.init()
        tableView.tableHeaderView = self?.foundHeaderView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 230
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(UINib.init(nibName: String.init(describing: MMLFoundTableViewCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: MMLFoundTableViewCell.self))
        return tableView
    }()
    
    private lazy var foundHeaderView: MMLFoundHeaderView = {
        let view = MMLFoundHeaderView.init(frame: CGRect.zero)
        view.parentVC = self
        return view
    }()
    
    private lazy var foundBrandViewModel: MMLFoundBrandViewModel = {
        let vm = MMLFoundBrandViewModel()
        vm.tableView = self.tableView
        return vm
    }()
}

// MARK: - UITableViewDataSource
extension MMLFoundVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = tableView.mj_footer {
            tableView.mj_footer.isHidden = foundBrandViewModel.brandList.isEmpty
        }
        return foundBrandViewModel.brandList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: MMLFoundTableViewCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: MMLFoundTableViewCell.self)) as? MMLFoundTableViewCell
        if let _ = cell {
        }else {
            cell = Bundle.main.loadNibNamed(String.init(describing: MMLFoundTableViewCell.self), owner: nil, options: nil)?.first as? MMLFoundTableViewCell
        }
        cell?.separatorInset.left = 0
        cell?.data = foundBrandViewModel.brandList[indexPath.row]
        return cell!
    }
    
}

// MARK: - UITableViewDelegate
extension MMLFoundVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = foundBrandViewModel.brandList[indexPath.row]
        let VC = MMLProductDetailsVC()
        VC.shoppingID = model.shopingID
        navigationController?.pushViewController(VC, animated: true)
    }
}
