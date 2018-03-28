//
//  CheckLogisticsCell.swift
//  Mythsbears
//
//  Created by macos on 2017/9/29.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class CheckLogisticsCell: UITableViewCell {

    @IBOutlet weak var iconBt: UIButton!
    
    @IBOutlet weak var line: UIView!
    
    @IBOutlet weak var titleLabels: UILabel!
    
    @IBOutlet weak var dateLabels: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

        iconBt.layer.cornerRadius = 5.0;
    
    }

    
    var setLoginsticsModel:LogisticsModel?{
        didSet{
            self.titleLabels.text = setLoginsticsModel?.remark;
            self.dateLabels.text = setLoginsticsModel?.datetime;
          
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
