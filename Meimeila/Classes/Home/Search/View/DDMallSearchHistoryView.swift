//
//  DDMallSearchHistoryView.swift
//  Mythsbears
//
//  Created by HJQ on 2017/9/20.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

@objc protocol DDMallSearchHistoryViewDlegate {
    func historyItemSelected(text: String)
}


class DDMallSearchHistoryView: UIView {

     weak var delegate: DDMallSearchHistoryViewDlegate?
    
    var datas: [String] = [String]() {
        didSet {
            //isHidden = datas.count == 0 ? true : false
            setupSubviews()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        adjustLayout()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func setupUI() {
        addSubview(headerView)
        addSubview(contentView)
    }
    
    private func setupSubviews() {
        
        contentView.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        var labelStarX: CGFloat = 10.0
        var labelStartY: CGFloat = 10.0
        let labelH: CGFloat = 30
        for i in 0 ..< datas.count {
            let label = DDSearchLabel.init()
            label.backgroundColor = UIColor.init(r: 246, g: 246, b: 246)
            label.textColor = DDGlobalNavTitleColor()
            label.font = UIFont.systemFont(ofSize: 14)
            label.isUserInteractionEnabled = true
            label.insets = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 5)
            label.text = datas[i]
            label.textAlignment = .center
            label.layer.masksToBounds = true
            label.layer.cornerRadius = 15
            label.layer.borderWidth = 1
            label.layer.borderColor = UIColor.RGB("#CDCDCD")?.cgColor
            if 85 + labelStarX > Screen.width {
                labelStarX = 10
                labelStartY += 10 + labelH
            }
            
            label.frame = CGRect.init(x: labelStarX, y: labelStartY, width: 85, height: labelH)
        
            contentView.addSubview(label)
            labelStarX += label.width + 20
            labelStartY = label.y
            
            // 添加手势点击
            let tagGes = UITapGestureRecognizer.init(target: self, action: #selector(itemClick(tap:)))
            label.addGestureRecognizer(tagGes)
            
        }
        contentView.frame = CGRect.init(x: 0, y: 40, width: Screen.width, height: labelStartY + labelH + 10)
        self.frame = CGRect.init(x: 0, y: 0, width: Screen.width, height: 40 + labelStartY + labelH + 10)
        
    }
    
    private func adjustLayout() {
        headerView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        iconImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(15)
            make.height.width.equalTo(20)
        }
        
        msgLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconImageView.snp.right).offset(5)
            make.centerY.equalToSuperview()
            
        }
        
    }
    
    // MARK: - Action methods
    @objc func itemClick(tap: UITapGestureRecognizer) {
        let label = tap.view as! UILabel
        let text = label.text!
        if let _ = delegate {
            delegate?.historyItemSelected(text: text)
        }
    }
    
    // MARK: - lazy load
    private lazy var headerView: UIView = {
        let headerView = UIView.init()
        headerView.backgroundColor = DDGlobalBGColor()
        headerView.addSubview(self.iconImageView)
        headerView.addSubview(self.msgLabel)
        return headerView
    }()
    
    private lazy var contentView: UIView = {
        let headerView = UIView.init()
        return headerView
    }()
    
    private lazy var iconImageView: UIImageView = {
        let view = UIImageView.init()
        view.image = UIImage.init(named: "recent_search")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var msgLabel: UILabel = {
        let label = UILabel.init()
        label.font = UIFont.systemFont(ofSize: 14)
        //label.textColor = UIColor.init(r: 203, g: 203, b: 203)
        label.text = "历史搜索"
        return label
    }()

}
