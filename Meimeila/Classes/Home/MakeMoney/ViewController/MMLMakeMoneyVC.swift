//
//  MMLMakeMoneyVC.swift
//  Meimeila
//
//  Created by HJQ on 2017/10/20.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLMakeMoneyVC: DDBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "我要赚钱"
    }
    
    override func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }


    // MARK: - Lazy load
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView.tableFooterView = UIView.init()
        //tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: String.init(describing: MMLMakeMoneyTableViewCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: MMLMakeMoneyTableViewCell.self))
        return tableView
    }()

}

// MARK: - UITableViewDataSource
extension MMLMakeMoneyVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: MMLMakeMoneyTableViewCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: MMLMakeMoneyTableViewCell.self)) as? MMLMakeMoneyTableViewCell
        if let _ = cell {
        }else {
            cell = Bundle.main.loadNibNamed(String.init(describing: MMLMakeMoneyTableViewCell.self), owner: nil, options: nil)?.first as? MMLMakeMoneyTableViewCell
        }
        return cell!
    }
    
}

// MARK: - UITableViewDelegate
extension MMLMakeMoneyVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
