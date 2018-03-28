//
//  DDShoppingCarBottomView.swift
//  Mythsbears
//
//  Created by HJQ on 2017/9/23.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

@objc protocol DDShoppingCarBottomViewDlegate {
    func  shoppingCarBottomViewSlectedButton(button: UIButton, type: Int)
}


class DDShoppingCarBottomView: UIView {

    var type: Bool = false{
        didSet {
            if type == true {
                deletedView.isHidden = false
                tosettleaccountsView.isHidden = true
            }else {
                deletedView.isHidden = true
                tosettleaccountsView.isHidden = false
            }
        }
    }
    
    // 设置总价
    func setupPriceInfo(totalPrice: Double,and Post:Double) {
        combinedLabel.text = "合计:￥\(totalPrice)"
        let attributeText = NSMutableAttributedString.init(string: combinedLabel.text!)
        attributeText.addAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)], range: NSMakeRange(0, 3))
        attributeText.addAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)], range: NSMakeRange(3, attributeText.length - 3))
        attributeText.addAttributes([NSAttributedStringKey.foregroundColor: UIColor.red], range: NSMakeRange(3, attributeText.length - 3))
        combinedLabel.attributedText = attributeText
        
        thefreightLabel.text = "运费:￥\(Post)";
        thefreightLabel.font = UIFont.systemFont(ofSize: 14);
    }
    
    weak var delegate: DDShoppingCarBottomViewDlegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        adjustLayout()
    }
    
    override func awakeFromNib() {
        setupUI()
        adjustLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func setupUI() {
        addSubview(tosettleaccountsView)
        addSubview(deletedView)
    }
    
    private func adjustLayout() {
        tosettleaccountsView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        deletedView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        // 删除
        deletedSeletedAllButton.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
            make.width.equalTo(85)
        }
        
        deletedButton.snp.makeConstraints { (make) in
            make.top.bottom.right.equalToSuperview()
            make.width.equalTo(120)
        }
        
        
        // 结算
        tosettleaccountsSelectedAllButton.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
            make.width.equalTo(85)
        }
        
        tosettleaccountsButton.snp.makeConstraints { (make) in
            make.top.bottom.right.equalToSuperview()
            make.width.equalTo(120)
        }
        
        combinedLabel.snp.makeConstraints { (make) in
            make.top.equalTo(5)
            make.left.equalTo(tosettleaccountsSelectedAllButton.snp.right)
            make.right.equalTo(tosettleaccountsButton.snp.left)
            make.height.equalTo(21)
        }
        
        thefreightLabel.snp.makeConstraints { (make) in
            make.top.equalTo(combinedLabel.snp.bottom).offset(2)
            make.left.equalTo(tosettleaccountsSelectedAllButton.snp.right)
            make.right.equalTo(tosettleaccountsButton.snp.left)
            make.height.equalTo(21)
        }
        
    }
    
    // MARK: - Action method
    @objc func buttonSelected(button: UIButton) {
        let tag = button.tag
        if let _ = delegate {
            delegate?.shoppingCarBottomViewSlectedButton(button: button, type: tag)
        }
    }
    

    // MARK: - lazy load
    private lazy var deletedView: UIView = {
        let view = UIView.init()
        view.isHidden = true
        view.addSubview(self.deletedSeletedAllButton)
        view.addSubview(self.deletedButton)
        return view
    }()
    
    private lazy var tosettleaccountsView: UIView = {
        let view = UIView.init()
        //view.isHidden = true
        view.addSubview(self.tosettleaccountsSelectedAllButton)
        view.addSubview(self.tosettleaccountsButton)
        view.addSubview(self.combinedLabel)
        view.addSubview(self.thefreightLabel)
        return view
    }()
    
    /// 删除
    // 全选删除
    private lazy var deletedSeletedAllButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.setImage(UIImage.init(named: "mall_icon_unselected"), for: .normal)
        button.setImage(UIImage.init(named: "mall_icon_selected"), for: .selected)
        button.setTitle("全选", for: .normal)
        button.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -10, bottom: 0, right: 0)
        button.tag = ShoppingCarBottomViewBtnType.deletedSelectedAllType.rawValue
        button.addTarget(self, action: #selector(buttonSelected(button:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var  deletedButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.setTitle("删除", for: .normal)
        button.backgroundColor = UIColor.red
        button.tag = ShoppingCarBottomViewBtnType.deletedType.rawValue
        button.addTarget(self, action: #selector(buttonSelected(button:)), for: .touchUpInside)
        return button
    }()
    
    /// 去结算
    private lazy var tosettleaccountsButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.setTitle("去结算", for: .normal)
        button.backgroundColor = UIColor.red
        button.tag = ShoppingCarBottomViewBtnType.tosettleaccountsType.rawValue
        button.addTarget(self, action: #selector(buttonSelected(button:)), for: .touchUpInside)
        return button
    }()
    
    // 全选去结算
    private lazy var tosettleaccountsSelectedAllButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.setImage(UIImage.init(named: ""), for: .normal)
        button.setTitle("全选", for: .normal)
        button.setImage(UIImage.init(named: "mall_icon_unselected"), for: .normal)
        button.setImage(UIImage.init(named: "mall_icon_selected"), for: .selected)
        button.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -10, bottom: 0, right: 0)
        button.tag = ShoppingCarBottomViewBtnType.tosettleaccountsSelectedAllType.rawValue
        button.addTarget(self, action: #selector(buttonSelected(button:)), for: .touchUpInside)
        return button
    }()
    
    // 合计
    private lazy var combinedLabel: UILabel = {
        let lable = UILabel.init()
        lable.text = "合计:￥0.0"
        let attributeText = NSMutableAttributedString.init(string: lable.text!)
        attributeText.addAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)], range: NSMakeRange(0, 3))
        attributeText.addAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)], range: NSMakeRange(3, attributeText.length - 3))
        attributeText.addAttributes([NSAttributedStringKey.foregroundColor: UIColor.red], range: NSMakeRange(3, attributeText.length - 3))
        lable.attributedText = attributeText
        return lable
    }()
    
    // 运费
    private lazy var thefreightLabel: UILabel = {
        let lable = UILabel.init()
        lable.text = "运费:￥0.0(不含运费)"
        let attributeText = NSMutableAttributedString.init(string: lable.text!)
        attributeText.addAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)], range: NSMakeRange(0, 3))
        attributeText.addAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)], range: NSMakeRange(3, attributeText.length - 3))
        lable.attributedText = attributeText
        return lable
    }()

}
