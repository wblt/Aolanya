//
//  ALYAreaVC.swift
//  Meimeila
//
//  Created by yanghuan on 2018/4/16.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import UIKit

class ALYAreaVC: DDBaseViewController {
	
	@IBOutlet weak var tableView: UITableView!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.navigationItem.title = "区域统计"
		bindMJRefresh()
    }
	
	override func setupUI() {
		self.tableView.delegate = self;
		self.tableView.dataSource = self;
		self.tableView.rowHeight = 105;
		self.tableView.tableFooterView = UIView.init();
		self.tableView.backgroundColor = DDGlobalBGColor();
		self.tableView.showsVerticalScrollIndicator = false;
		self.tableView.separatorColor = UIColor.clear;
		self.tableView.register(UINib.init(nibName: String.init(describing: ALYAreaStatisticsTabCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: ALYAreaStatisticsTabCell.self));
	}
	
	///MJ
	func bindMJRefresh() {
		setupRefresh(tableView, isNeedFooterRefresh: false, headerCallback: {[weak self] in
			
			
		}) {[weak self] in
			
			
		}
	}
	

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ALYAreaVC:UITableViewDelegate{
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
	}
	
}

extension ALYAreaVC:UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 10
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 150
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		var cell:ALYAreaStatisticsTabCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: ALYAreaStatisticsTabCell.self)) as? ALYAreaStatisticsTabCell;
		cell?.separatorInset.left = 0;
		cell?.selectionStyle = .none;
		cell?.backgroundColor =  UIColor.RGB(r: 245, g: 245, b: 245)
		if let _ = cell {
			
		}else{
			
			cell = Bundle.main.loadNibNamed(String.init(describing: ALYAreaStatisticsTabCell.self), owner: nil, options: nil)?.last as? ALYAreaStatisticsTabCell;
		}
		
		return cell!;
	}
	
}
