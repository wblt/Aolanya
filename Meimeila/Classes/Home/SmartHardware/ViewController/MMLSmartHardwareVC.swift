//
//  MMLSmartHardwareVC.swift
//  Meimeila
//
//  Created by HJQ on 2017/11/21.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLSmartHardwareVC: DDBaseViewController {

    // 如果不写这个方法，iOS8会崩溃
    init() {
        super.init(nibName: String.init(describing: MMLSmartHardwareVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "智能硬件"

    }
    
    override func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Private methods
    
    
    // MARK: - Lazy load
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView.tableFooterView = UIView.init()
        tableView.separatorInset.left = 0
        tableView.backgroundColor = DDGlobalBGColor()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: String.init(describing: MMLSmartHardwareCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: MMLSmartHardwareCell.self))
        return tableView
    }()
    
    private var datas: [[String: String]] = {
        var array = [[String: String]] ()
        let dict1 = ["icon":"hardware_mask", "name": "智能面膜"]
        let dict2 = ["icon":"hardware_bracelet", "name": "智能手表"]
        let dict3 = ["icon":"hardware_placket", "name": "智能胸贴"]
        array.append(dict1)
        array.append(dict2)
        array.append(dict3)
        return array
    }()
}

// MARK: - UITableViewDelegate
extension MMLSmartHardwareVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            let VC = DDSmartmaskVC()
            navigationController?.pushViewController(VC, animated: true)
            break
        case 1:
            BFunction.shared.showToastMessge("智能手表暂未开放")
            break
        case 2:
            BFunction.shared.showToastMessge("智能胸贴暂未开放")
            break
        default: break;
            
        }

    }
}

extension MMLSmartHardwareVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return datas.count
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: MMLSmartHardwareCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: MMLSmartHardwareCell.self)) as? MMLSmartHardwareCell
        if let _ = cell {}
        else {
            cell = Bundle.main.loadNibNamed(String.init(describing: MMLSmartHardwareCell.self), owner: nil, options: nil)?.first as? MMLSmartHardwareCell
        }
        cell?.dict = datas[indexPath.row]
        cell?.accessoryType = .disclosureIndicator
        return cell!
    }
}
