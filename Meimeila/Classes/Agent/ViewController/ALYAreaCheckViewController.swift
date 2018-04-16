//
//  ALYAreaCheckViewController.swift
//  Meimeila
//
//  Created by yanghuan on 2018/4/16.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import UIKit

class ALYAreaCheckViewController: DDBaseViewController {
	@IBOutlet weak var tableView: UITableView!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.navigationItem.title = "区域审核"
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
		self.tableView.register(UINib.init(nibName: String.init(describing: ALYAgentCardTabCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: ALYAgentCardTabCell.self));
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

extension ALYAreaCheckViewController:UITableViewDelegate{
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
	}
	
}

extension ALYAreaCheckViewController:UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 10
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 195
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		var cell:ALYAgentCardTabCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: ALYAgentCardTabCell.self)) as? ALYAgentCardTabCell;
		cell?.separatorInset.left = 0;
		cell?.selectionStyle = .none;
		cell?.backgroundColor =  UIColor.RGB(r: 245, g: 245, b: 245)
		if let _ = cell {
			
		}else{
			
			cell = Bundle.main.loadNibNamed(String.init(describing: ALYAgentCardTabCell.self), owner: nil, options: nil)?.last as? ALYAgentCardTabCell;
		}
		cell?.addresstitleLab.text = "申请区域："
		
		return cell!;
	}
	
	func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		let bgView = UIView()
		bgView.frame = CGRect.init(x: 0, y: 0, width: self.view.width, height: 50)
		bgView.backgroundColor = UIColor.clear
		
		let confuseBtn = UIButton()
		confuseBtn.frame = CGRect.init(x: 20, y: 5, width: (self.view.width-60)/2, height: 40)
		confuseBtn.setTitle("拒绝", for: UIControlState.normal)
		confuseBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
		confuseBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
		confuseBtn.backgroundColor = DDGlobalNavTitleColor();
		confuseBtn.setCornerBorderWithCornerRadii(20, width: 0.1, color: UIColor.clear)
		
		let agreenBtn = UIButton()
		agreenBtn.frame = CGRect.init(x: self.view.width/2+10, y: 5, width: (self.view.width-60)/2, height: 40)
		agreenBtn.setTitle("同意", for: UIControlState.normal)
		agreenBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
		agreenBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
		agreenBtn.backgroundColor = DDGlobalNavBarColor();
		agreenBtn.setCornerBorderWithCornerRadii(20, width: 0.1, color: UIColor.clear)
		
		bgView.addSubview(confuseBtn)
		bgView.addSubview(agreenBtn)
		
		
		return bgView
	}
	
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return 50
	}
	
}
