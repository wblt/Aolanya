//
//  ALYOrderManagerTabCell.swift
//  Meimeila
//
//  Created by yanghuan on 2018/4/16.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import UIKit

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
