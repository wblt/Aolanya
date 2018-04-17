//
//  ALYAreaDetailsTabCell.swift
//  Meimeila
//
//  Created by yanghuan on 2018/4/17.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import UIKit

class ALYAreaDetailsTabCell: UITableViewCell {

	@IBOutlet weak var monthLab: UILabel!
	
	@IBOutlet weak var cityLab: UILabel!
	
	@IBOutlet weak var proviceLab: UILabel!
	
	
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
