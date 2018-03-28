//
//  DDShoppingCarListCell.swift
//  Mythsbears
//
//  Created by HJQ on 2017/9/23.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

@objc protocol DDShoppingCarListCellDelegate {
    // 选择商品
    func selectedProduct(indexPath: IndexPath)
    func productIncrease(indexPath: IndexPath, addOrSubView: DDProductAddOrSubtractView, textField: UITextField)
    func productDeIncrease(indexPath: IndexPath, addOrSubView: DDProductAddOrSubtractView, textField: UITextField)
}

class DDShoppingCarListCell: UITableViewCell {

    weak var delegate: DDShoppingCarListCellDelegate?
    
    // 原价
    @IBOutlet weak var originalPriceLabel: DDAddDeletedLineLabel!
    @IBOutlet weak var productImageView: UIImageView!
    // 现价
    @IBOutlet weak var presentpriceLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    
    @IBOutlet weak var selectedButton: UIButton!
    @IBOutlet weak var addOrSubView: DDProductAddOrSubtractView!
    
    var indexPath: IndexPath!
    // false为支付状态 true为商品删除
    var type: Bool = false
    var shoppingCarListData: DDShoppingCarListData! {
        didSet {
            productNameLabel.text = shoppingCarListData.shopingName
            productImageView.jq_setImage(imageUrl: kPrefixLink + shoppingCarListData.shopingImg,  placeholder: "http_error")
            presentpriceLabel.text = "￥" + shoppingCarListData.price
            addOrSubView.setStartNumber(number: Int(shoppingCarListData.shoppingCartNumber)!)
            
            // 状态重置
            selectedButton.isSelected = false
            if type == false { // 正常的结算
               selectedButton.isSelected = shoppingCarListData.isSelectedPay
                
            }else { // 商品删除
                selectedButton.isSelected = shoppingCarListData.isSelectedDeleted
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addOrSubView.delegate = self
        originalPriceLabel.sizeToFit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - event respose
    @IBAction func selectedButtonAction(_ sender: Any) {
        let button = sender as! UIButton
        button.isSelected = !button.isSelected
        if type == false {
            shoppingCarListData.isSelectedPay = button.isSelected
        }else {
            shoppingCarListData.isSelectedDeleted = button.isSelected
        }
        if let _ = delegate {
            delegate?.selectedProduct(indexPath: indexPath)
        }
    }
}

extension DDShoppingCarListCell: DDProductAddOrSubtractViewDlegate {
    
    // 直接输入数目的回调
    func productAddOrSubtractViewEnterNumber(number: Int) {
        print(number)
    }
    
    // 增加的回调
    func productAddOrSubtractViewIncrease(textField: UITextField,  increasButton: UIButton) {
        if let _ = delegate {
            delegate?.productIncrease(indexPath: indexPath, addOrSubView: addOrSubView, textField: textField)
        }
    }
    
    // 减少的回调
    func productAddOrSubtractViewDeincrease(textField: UITextField, deincreaseButton: UIButton) {
        if let _ = delegate {
            delegate?.productDeIncrease(indexPath: indexPath, addOrSubView: addOrSubView, textField: textField)
        }
    }
    
    // 快速变化的回调
    func productAddOrSubtractViewFastChange(type: Int, number: Int) {
        let status = DDProductAddOrSubtractViewStatus(rawValue: type)!
        switch status {
        case .productDeincreaseType:
            break
        case .productIncreaseType:
            break
        }
        //print(number)
    }
}
