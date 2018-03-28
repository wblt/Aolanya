//
//  MMLShareCollectionViewCell.swift
//  Meimeila
//
//  Created by HJQ on 2017/10/18.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLShareCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var dict: [String: Any]? {
        didSet {
            iconImageView.image = UIImage.init(named: dict!["iconName"] as? String ?? " ")
            nameLabel.text = dict?["title"] as? String  ?? " "
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconImageView.contentMode = .scaleAspectFit
        // Initialization code
    }

}
