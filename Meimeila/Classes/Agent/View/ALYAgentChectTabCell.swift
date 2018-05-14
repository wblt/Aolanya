//
//  ALYAgentChectTabCell.swift
//  Meimeila
//
//  Created by yanghuan on 2018/5/14.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import UIKit

class ALYAgentChectTabCell: UITableViewCell {
	@IBOutlet weak var levelTitleLab: UILabel!
	
	
	@IBOutlet weak var nameLab: UILabel!
	
	
	@IBOutlet weak var phoneLab: UILabel!
	
	@IBOutlet weak var weixinLab: UILabel!
	
	@IBOutlet weak var adddressLab: UILabel!
	
	@IBOutlet weak var imgTitleLab: UILabel!
	
	@IBOutlet weak var leftImgView: UIImageView!
	
	@IBOutlet weak var rightImgView: UIImageView!
	
	//
	var data: AgentInfoDataModel? {
		didSet {
			levelTitleLab.text = data?.level
			if data?.agentLevel == "5" {
				levelTitleLab.text = "联合创始人"
			}else if data?.agentLevel == "4" {
				levelTitleLab.text = "联合股东"
			}else if data?.agentLevel == "3" {
				levelTitleLab.text = "大区"
			}else if data?.agentLevel == "2" {
				levelTitleLab.text = "金牌会员"
			}else  { //1
				levelTitleLab.text = "零售"
			}
			
			nameLab.text = data?.realName
			phoneLab.text = data?.phone
			weixinLab.text = data?.weChat ?? ""
			adddressLab.text = data?.address
			imgTitleLab.text = (data?.realName)! + "的收款码"
			leftImgView.jq_setImage(imageUrl: data?.weChatPayment)
			rightImgView.jq_setImage(imageUrl: data?.alipayPayment)
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
