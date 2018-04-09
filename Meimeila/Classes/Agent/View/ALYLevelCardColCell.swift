//
//  ALYLevelCardColCell.swift
//  Meimeila
//
//  Created by yanghuan on 2018/4/9.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import UIKit

class ALYLevelCardColCell: UICollectionViewCell {

	@IBOutlet weak var levelTitleLab: UILabel!
	
	@IBOutlet weak var firstLab: UILabel!
	
	@IBOutlet weak var firstMoneyLab: UILabel!
	
	@IBOutlet weak var totalLab: UILabel!
	
	@IBOutlet weak var totalMoneyLab: UILabel!
	
	@IBOutlet weak var remarksLab: UILabel!
	
	var cardDataModel: LevelCardModel? {
		didSet {
			levelTitleLab.text = cardDataModel?.title
			firstMoneyLab.text = "￥" + (cardDataModel?.money)!
			totalMoneyLab.text = "￥" + (cardDataModel?.money2)!
			remarksLab.text = "满足该层级进货要求，有产品的销售权，并享受\((cardDataModel?.remarks)!)代理优惠"
			
			self.backgroundColor = UIColor.init(hexString: (cardDataModel?.color_bg)!)
			
			if cardDataModel?.color_bg == "#000000" {
				levelTitleLab.textColor =  UIColor.yellow
				firstLab.textColor = UIColor.yellow
				totalLab.textColor = UIColor.yellow
				remarksLab.textColor = UIColor.yellow
			}else {
				levelTitleLab.textColor =  UIColor.black
				firstLab.textColor = UIColor.black
				totalLab.textColor = UIColor.black
				remarksLab.textColor = UIColor.black
			}
		}
	}
	
	
	
	
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
