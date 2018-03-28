//
//  MMLEditeUserCell.swift
//  Meimeila
//
//  Created by macos on 2017/10/23.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLEditeUserCell: UITableViewCell {

    @IBOutlet weak var cellTitleLabel: UILabel!
    
    
    @IBOutlet weak var cellDetailLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    var  setInfo:String = "" {
        
        didSet{
    
            cellDetailLabel.text = setInfo;
    
        }
    }
    
    
}
