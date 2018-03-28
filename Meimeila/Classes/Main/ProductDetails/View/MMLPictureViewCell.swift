//
//  MMLPictureViewCell.swift
//  Meimeila
//
//  Created by HJQ on 2017/10/19.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLPictureViewCell: UICollectionViewCell {

    var imageStr: String? {
        didSet {
            iconImageView.jq_setImage(imageUrl: imageStr)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    
    // MARK: - Private method
    private func setupUI() {
        // 1.添加子控件
        contentView.addSubview(iconImageView)
        //iconImageView.addSubview(gifImageView)
        
        iconImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - 懒加载
    private lazy var iconImageView: UIImageView = UIImageView()
    private lazy var gifImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "avatar_vgirl"))
        iv.isHidden = true
        return iv
    }()

}
