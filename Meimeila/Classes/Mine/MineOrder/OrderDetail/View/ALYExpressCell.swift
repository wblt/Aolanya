//
//  ALYExpressCell.swift
//  Meimeila
//
//  Created by yanghuan on 2018/6/28.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import UIKit

class ALYExpressCell: UITableViewCell {
	@IBOutlet weak var kuaidiNumTextField: UITextField!
	
	@IBOutlet weak var kuaidiNameTextField: UITextField!
	@IBOutlet weak var saoyisaoBtn: UIButton!
	
	@IBOutlet weak var sendBtn: UIButton!
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
