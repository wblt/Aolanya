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
	
	
	
	
	
	
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
