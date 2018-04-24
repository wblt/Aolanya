//
//  MMLHomeListTableViewCell.swift
//  Meimeila
//
//  Created by HJQ on 2017/10/17.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLHomeListTableViewCell: UITableViewCell {

    var shoppingData: MMLHomeDataShoping? {
        didSet {
            productNameImageView.jq_setImage(imageUrl: kPrefixLink + (shoppingData?.shopingImg)!,  placeholder: "http_error")
            nameLabel.text = shoppingData?.shopingName
            descLabel.text = shoppingData?.shopingMessage
            priceLabel.text = "￥" + (shoppingData?.price)!
            saleLabel.text = (shoppingData?.salesCount)! + "人已付款"
            marketpriceLabel.text = "￥" + (shoppingData?.market_value)!
            marketpriceLabel.sizeToFit()
            marketpriceLabel.textColor = UIColor.orange
        }
    }
    
    // 搜索商品列表
    var productListData: DDProductListShopping! {
        didSet {
            productNameImageView.jq_setImage(imageUrl: kPrefixLink + (productListData?.shopingImg)!,  placeholder: "http_error")
            nameLabel.text = productListData?.shopingName
            descLabel.text = productListData?.shopingMessage
            priceLabel.text = "￥" + (productListData?.price)!
            saleLabel.text = (productListData?.salesCount)! + "人已付款"
            marketpriceLabel.text = "￥" + (productListData?.market_value)!
            marketpriceLabel.sizeToFit()
        }
    }
    
    @IBOutlet weak var productNameImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var saleLabel: UILabel!
    @IBOutlet weak var marketpriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
