//
//  MMLReportShareCell.swift
//  Meimeila
//
//  Created by macos on 2017/11/30.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

@objc protocol MMLReportShareCellDelegate{
    
    func shareAction(type:Int)
}

class MMLReportShareCell: UITableViewCell {

    
    @IBOutlet weak var greenCube: UIView!
    
    
    weak var delegate:MMLReportShareCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()

    
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
