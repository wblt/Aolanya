//
//  ALYSureMoneyCell.swift
//  Meimeila
//
//  Created by yanghuan on 2018/6/28.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import UIKit

class ALYSureMoneyCell: UITableViewCell {

	@IBOutlet weak var numTextField: UITextField!
	
	@IBOutlet weak var lookImgBtn: UIButton!
	
	@IBOutlet weak var sureMoneyBtn: UIButton!
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
