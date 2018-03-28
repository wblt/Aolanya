//
//  MMLRedenvelopeCell.swift
//  Meimeila
//
//  Created by HJQ on 2017/10/20.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

@objc protocol MMLRedenvelopeCellDelegate {
    func  redenvelopeCellReceive(index: Int)
}

class MMLRedenvelopeCell: UITableViewCell {

    weak var delegate: MMLRedenvelopeCellDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    var indexPath: IndexPath!
    
    var dict: [String: String]? {
        didSet {
            titleLabel.text = dict?["title"]
            timeLabel.text = dict?["time"]
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
    
    // MARK: - Event respse
    // 领取红包
    @IBAction func receiveAction(_ sender: Any) {
        if let _ = delegate {
            delegate?.redenvelopeCellReceive(index: indexPath.row)
        }
    }
}
