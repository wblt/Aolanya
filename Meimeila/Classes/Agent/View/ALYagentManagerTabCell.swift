//
//  ALYagentManagerTabCell.swift
//  Meimeila
//
//  Created by yanghuan on 2018/4/16.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import UIKit

//@objc protocol ALYagentManagerTabCellDelegate {
//
//	 func looklowerAgent(model:AgentInfoDataModel?)
//
//}

protocol ALYagentManagerTabCellDelegate : class {
	 func looklowerAgent(model:AgentInfoDataModel?)
}

class ALYagentManagerTabCell: UITableViewCell {

	@IBOutlet weak var leveTitlelab: UILabel!
	
	
	@IBOutlet weak var nameLab: UILabel!
	
	
	@IBOutlet weak var phoneLab: UILabel!
	
	@IBOutlet weak var weixinLab: UILabel!
	
	
	@IBOutlet weak var addressLab: UILabel!
	
	
	@IBOutlet weak var lookNextBtn: UIButton!
	
	weak var delegate: ALYagentManagerTabCellDelegate?
	
	@IBAction func lookNextAction(_ sender: Any) {
		if let _ = self.delegate {
			self.delegate?.looklowerAgent(model: self.data)
		}
	}
	
	var data: AgentInfoDataModel? {
		didSet {
			lookNextBtn.setCornerBorderWithCornerRadii(15, width: 0.001, color: UIColor.clear);
			lookNextBtn.backgroundColor = DDGlobalNavBarColor()
			
			if data?.level == "5" {
				leveTitlelab.text = "联合创始人"
			}else if data?.level == "4" {
				leveTitlelab.text = "联合股东"
			}else if data?.level == "3" {
				leveTitlelab.text = "大区"
			}else if data?.level == "2" {
				leveTitlelab.text = "金牌会员"
			}else  { //1
				leveTitlelab.text = "零售"
			}
			nameLab.text = data?.realName
			phoneLab.text = data?.phone
			weixinLab.text = data?.weChat ?? ""
			addressLab.text = data?.address
			lookNextBtn.setTitle("查看\"\(data?.realName ?? "")\"的下级", for: UIControlState.normal)
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
