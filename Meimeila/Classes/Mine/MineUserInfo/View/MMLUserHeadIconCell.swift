//
//  MMLUserHeadIconCell.swift
//  Meimeila
//
//  Created by macos on 2017/10/23.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLUserHeadIconCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var headIconImageView: UIImageView!
   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var setIcon:String?{
        
        didSet{
            
            headIconImageView.jq_setImage(imageUrl: setIcon ?? "0", placeholder: "icon_defaultHeadIcon", isShowIndicator: false, isNeedForceRefresh: false);
        }
    }
}
