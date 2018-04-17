//
//  ALYAgentCardTabCell.swift
//  Meimeila
//
//  Created by yanghuan on 2018/4/16.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import UIKit

class ALYAgentCardTabCell: UITableViewCell {
	
	@IBOutlet weak var levelTitleLab: UILabel!
	
	
	@IBOutlet weak var nameLab: UILabel!
	
	
	@IBOutlet weak var phoneLab: UILabel!
	
	@IBOutlet weak var weixinLab: UILabel!
	
	@IBOutlet weak var adddressLab: UILabel!
	
	@IBOutlet weak var addresstitleLab: UILabel!

	// 上级代理人
	var data: AgentInfoDataModel? {
		didSet {
			levelTitleLab.text = data?.level
			if data?.level == "5" {
				levelTitleLab.text = "联合创始人"
			}else if data?.level == "4" {
				levelTitleLab.text = "联合股东"
			}else if data?.level == "3" {
				levelTitleLab.text = "大区"
			}else if data?.level == "2" {
				levelTitleLab.text = "金牌会员"
			}else  { //1
				levelTitleLab.text = "零售"
			}
			
			nameLab.text = data?.realName
			phoneLab.text = data?.phone
			weixinLab.text = data?.weChat ?? ""
			adddressLab.text = data?.address
			addresstitleLab.text = "地址："
		}
	}
	
	// 区域审核代理人
	var data1: AgentInfoDataModel? {
		didSet {
			levelTitleLab.text = data1?.level
			nameLab.text = data1?.realName
			phoneLab.text = data1?.phone
			weixinLab.text = data1?.weChat ?? ""
			adddressLab.text = data1?.regionAdress
			addresstitleLab.text = "申请区域："
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
