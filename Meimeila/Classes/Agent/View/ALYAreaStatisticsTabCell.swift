//
//  ALYAreaStatisticsTabCell.swift
//  Meimeila
//
//  Created by yanghuan on 2018/4/16.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import UIKit

class ALYAreaStatisticsTabCell: UITableViewCell {

	@IBOutlet weak var provinceLab: UILabel!
	
	
	@IBOutlet weak var cityLab: UILabel!
	
	@IBOutlet weak var provincePeoLab: UILabel!
	
	@IBOutlet weak var cityPeoLab: UILabel!
	
	
	
	var data: RegionShoppingModel? {
		didSet {
			provinceLab.text = data?.regionProvince
			cityLab.text = data?.regionCity
			provincePeoLab.text = "此省无合伙人"
			cityPeoLab.text = "此市无合伙人"
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
