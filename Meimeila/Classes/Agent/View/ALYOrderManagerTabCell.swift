//
//  ALYOrderManagerTabCell.swift
//  Meimeila
//
//  Created by yanghuan on 2018/4/16.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON

class ALYOrderManagerTabCell: UITableViewCell {
    @IBOutlet weak var nameLab: UILabel!
	
	@IBOutlet weak var levelLab: UILabel!
	
	
	@IBOutlet weak var numLab: UILabel!
	
	@IBOutlet weak var totalPriceLab: UILabel!
	
	
	var data: SubordinateShoopingModel? {
		didSet {
			//leveTitlelab.text = data?.realName
			nameLab.text = data?.realName
			
			if data?.level == "5" {
				levelLab.text = "联合创始人"
			}else if data?.level == "4" {
				levelLab.text = "联合股东"
			}else if data?.level == "3" {
				levelLab.text = "大区"
			}else if data?.level == "2" {
				levelLab.text = "金牌会员"
			}else  { //1
				levelLab.text = "零售"
			}
			
			numLab.text = data?.dataCount ?? ""
			totalPriceLab.text = "￥:" + (data?.dataCount)!
			
			var sellMoney = 0.0 as Float
				
			data?.shoppingHistoryData.forEach({ (item) in
					// 循环遍历 这里面的字段  价格*数量 === 等有数据了一起加上来
					let dic = JSON.init(item)
					let money = dic["paymentMoney"].floatValue
					sellMoney += money
			})
			totalPriceLab.text = "￥:" + "\(sellMoney)"
			
		}
	}
	
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
