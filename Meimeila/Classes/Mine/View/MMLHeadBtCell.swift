//
//  MMLHeadBtCell.swift
//  Meimeila
//
//  Created by macos on 2017/10/19.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLHeadBtCell: UICollectionViewCell {

    @IBOutlet weak var cellTitleLabel: UILabel!
    
    @IBOutlet weak var cellImageView: UIImageView!
    
    @IBOutlet weak var cellLine: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    var setDic:[String:String] = [:]{
        
        didSet{
            
            cellTitleLabel.text = setDic["name"];
            cellImageView.image = UIImage.init(named: setDic["icon"]!);
        }
    }
    
    
}
