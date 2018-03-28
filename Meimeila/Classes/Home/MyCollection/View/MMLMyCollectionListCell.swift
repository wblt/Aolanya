//
//  MMLMyCollectionListCell.swift
//  Meimeila
//
//  Created by HJQ on 2017/10/20.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLMyCollectionListCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var collectionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var data: MMLMyCollectionListData? {
        didSet {
            productImageView.jq_setImage(imageUrl: kPrefixLink + (data?.shopingImg)!, placeholder: "http_error")
            productNameLabel.text = data?.shopingName
            collectionLabel.text = "收藏" + (data?.collectionCount)!
            priceLabel.text = "￥" + (data?.price)!
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
