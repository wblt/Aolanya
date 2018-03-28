//
//  MMLFoundTableViewCell.swift
//  Meimeila
//
//  Created by HJQ on 2017/10/17.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLFoundTableViewCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var collectionButton: UIButton!
    @IBOutlet weak var readingLabel: UILabel!
    
    var data: MMLFoundBrandFoundBrand! {
        didSet {
            productImageView.jq_setImage(imageUrl: kPrefixLink + data.brandImg, placeholder: "http_error")
            titleLabel.text = data.brandName
            descLabel.text = data.brandMessage
            priceLabel.text = "￥" + data.price
            readingLabel.text = "阅读 " + data.readingCount
            collectionButton.setTitle(data.collectionCount, for: .normal)
            collectionButton.setTitle(data.collectionCount, for: .selected)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionButton.imageView?.contentMode = .scaleAspectFit
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
