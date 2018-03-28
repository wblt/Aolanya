//
//  MMLHeaderViewModuleCell.swift
//  Meimeila
//
//  Created by HJQ on 2017/10/17.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLHeaderViewModuleCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var dict: Dictionary<String, Any>?{
        didSet {
            nameLabel.text = dict?["title"]  as? String ?? ""
            iconImageView.image = UIImage.init(named: dict?["iconName"] as? String ?? " " )
        }
    }
    
    var dict1: Dictionary<String, String>?{
        didSet {
            nameLabel.text = dict1?["title"] ?? ""
            iconImageView.image = UIImage.init(named: dict1?["iconName"] ?? " " )
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
