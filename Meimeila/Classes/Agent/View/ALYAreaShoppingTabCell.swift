//
//  ALYAreaShoppingTabCell.swift
//  Meimeila
//
//  Created by yanghuan on 2018/4/17.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import UIKit
import Kingfisher

class ALYAreaShoppingTabCell: UITableViewCell {
	@IBOutlet weak var shopImgView: UIImageView!
	
	@IBOutlet weak var numLab: UILabel!
	@IBOutlet weak var nameLab: UILabel!
	
	
	var data: ShoppingDataModel? {
		didSet {
			shopImgView.jq_setImage(imageUrl: data?.shoppingImg, placeholder: "http_error", isShowIndicator: false, isNeedForceRefresh: false)
			numLab.text = data?.shoppingTotalNum
			nameLab.text = data?.shoppingName
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
