//
//  ALYAreaShoppingDataVC.swift
//  Meimeila
//
//  Created by yanghuan on 2018/4/17.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import UIKit

class ALYAreaShoppingDataVC: DDBaseViewController {
	
	var shoppingDataArray = [ShoppingDataModel]()
	
	@IBOutlet weak var tableView: UITableView!
	
	//iOS8用到XIB必须写这两个方法
	init() {
		super.init(nibName: String.init(describing: ALYAreaShoppingDataVC.self), bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		self.navigationItem.title = "区域统计"
    }

	override func setupUI() {
		self.tableView.delegate = self;
		self.tableView.dataSource = self;
		self.tableView.rowHeight = 105;
		self.tableView.tableFooterView = UIView.init();
		self.tableView.backgroundColor = DDGlobalBGColor();
		self.tableView.separatorColor = UIColor.black;
		self.tableView.showsVerticalScrollIndicator = false;
		self.tableView.register(UINib.init(nibName: String.init(describing: ALYAreaShoppingTabCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: ALYAreaShoppingTabCell.self));
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

extension ALYAreaShoppingDataVC:UITableViewDelegate{
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
	}
	
}

extension ALYAreaShoppingDataVC:UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return shoppingDataArray.count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 112
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 0.01;
	}
	
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return 0.01;
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		var cell:ALYAreaShoppingTabCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: ALYAreaShoppingTabCell.self)) as? ALYAreaShoppingTabCell;
		cell?.separatorInset.left = 0;
		cell?.selectionStyle = .none;
		cell?.backgroundColor =  UIColor.RGB(r: 245, g: 245, b: 245)
		if let _ = cell {
			
		}else{
			
			cell = Bundle.main.loadNibNamed(String.init(describing: ALYAreaShoppingTabCell.self), owner: nil, options: nil)?.last as? ALYAreaShoppingTabCell;
		}
		cell?.data = shoppingDataArray[indexPath.section];
		
		return cell!;
	}
	
}
