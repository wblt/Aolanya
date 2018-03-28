//
//  MMLProductIntroduceCell.swift
//  Meimeila
//
//  Created by HJQ on 2017/10/19.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import Kingfisher

@objc protocol MMLProductIntroduceCellDelegate {
    func introduceDownLoadFinish(indexPath: IndexPath)
}

class MMLProductIntroduceCell: UITableViewCell {

    @IBOutlet weak var contentImageView: UIImageView!
    var indexPath: IndexPath!
    weak var delegate: MMLProductIntroduceCellDelegate?
    private var isFinish: Bool = false
    
    var imageUrlStr: String? {
        didSet {
            //contentImageView.jq_setImage(imageUrl: kPrefixLink + imageUrlStr! )
            let url = URL.init(string: imageUrlStr!)
            contentImageView.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil) { (image, nil, _, _) in
                if let _ = self.delegate {
                    self.delegate?.introduceDownLoadFinish(indexPath: self.indexPath)
                }
            }
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
