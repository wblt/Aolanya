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
	
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
