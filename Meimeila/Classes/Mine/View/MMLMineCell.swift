//
//  MMLMineCell.swift
//  Meimeila
//
//  Created by macos on 2017/10/19.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLMineCell: UITableViewCell {

    @IBOutlet weak var cellImage: UIImageView!
   
    
    @IBOutlet weak var cellTitleLabel: UILabel!
    // 我的邀请码
	@IBOutlet weak var celllNumLabel: UILabel!
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	func setInvateCode(code:String) {
		celllNumLabel.text = code
	}
	
    
    var setDic:[String:String] = [:] {
        
        didSet{
            cellImage.image = UIImage.init(named: setDic["icon"]!)
            cellTitleLabel.text = setDic["name"]
        }
    }
    
}
