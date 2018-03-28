//
//  DayTaskCell.swift
//  Mythsbears
//
//  Created by macos on 2017/10/10.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class DayTaskCell: UITableViewCell {

    
    @IBOutlet weak var cellTitleLabel: UILabel!
    
    @IBOutlet weak var taskStatueLabel: UILabel!
    
    @IBOutlet weak var countDouLabel: UILabel!
    
    
    @IBOutlet weak var bluePoint: UIImageView!
   
    override func awakeFromNib() {
        super.awakeFromNib()

        bluePoint.layer.cornerRadius = 5;
    
    }

    var setDayTaskModel:DayTaskModel?{
        didSet{
            cellTitleLabel.text = setDayTaskModel?.name ?? ""
            countDouLabel.text = "+\(setDayTaskModel?.reward ?? "0")";
            taskStatueLabel.text = setDayTaskModel?.statusSteing;
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
