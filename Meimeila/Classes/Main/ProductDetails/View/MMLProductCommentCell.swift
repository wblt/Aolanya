//
//  MMLProductCommentCell.swift
//  Meimeila
//
//  Created by HJQ on 2017/10/19.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

@objc protocol MMLProductCommentCellDelegate {
    func productCommentCellShopFabulous(button: UIButton, currentIndex: Int)
    // 查看评论图片大图
    func viewCommentImages(contentImags: [String], currentIndex: Int)
}

class MMLProductCommentCell: UITableViewCell {

    weak var delegate: MMLProductCommentCellDelegate?
    var indexPath: IndexPath!
    
    var shopFabulousButtonClick: ((_ button: UIButton) -> ())?
    
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var commentImageView: UIImageView!
    @IBOutlet weak var shopFabulousButton: UIButton!
    
    // 多张评论图片
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightCons: NSLayoutConstraint!
    private var images: [String] = [String]()
    
    
    var evaluateData: MMLProductDetailsEvaluateData? {
        didSet {
            let imageUrl = (evaluateData?.picture)!.hasPrefix("http") ? (evaluateData?.picture)! : (kPrefixLink + (evaluateData?.picture)!)
            headerImageView.jq_setImage(imageUrl: imageUrl,  placeholder: "http_error")
            nameLabel.text = evaluateData?.name
            timeLabel.text = timestampToDate(format: "yyyy-mm-dd", timestamp: (evaluateData?.evaluateTime)!)
            contentLabel.text = evaluateData?.evaluateMessage
            
            shopFabulousButton.isSelected = (evaluateData?.totalFabulous) > 0 ? true : false
            shopFabulousButton.setTitle( " " + (evaluateData?.fabulous)!, for: .normal)
            shopFabulousButton.setTitle( " " + (evaluateData?.fabulous)!, for: .selected)
            
            images = (evaluateData?.evaluateImg.components(separatedBy: ","))!
            if evaluateData?.evaluateImg == "" {
                images.removeAll()
            }
            let column = 3
            let row = images.count % column == 0 ? images.count / column : (images.count / column) + 1
            let itemWH = (collectionView.width - 10.0) / 3.0
            let height = CGFloat(Int(itemWH) * row + (5 * (row - 1))) > 0 ? CGFloat(Int(itemWH) * row + (5 * (row - 1))) : 0
            collectionViewHeightCons.constant = height
            collectionView.reloadData()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Private method
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.backgroundColor = UIColor.white
        collectionView.isScrollEnabled = false
        collectionView.register(UINib.init(nibName: String.init(describing: DDProductCommentsImageCell.self), bundle: nil), forCellWithReuseIdentifier: String.init(describing: DDProductCommentsImageCell.self))
    }
    
    // MARK: - Event respose
    // 商品评价点赞
    @IBAction func shopFabulousButtonAction(_ sender: Any) {
        let button = sender as! UIButton
        if let _ = delegate {
            delegate?.productCommentCellShopFabulous(button: button, currentIndex: indexPath.row)
        }
        if let _ = shopFabulousButtonClick {
            shopFabulousButtonClick!(button)
        }
    }
    
    // MARK: - Lazy load
    /// 配图
    private lazy var pictureView: MMLStatusPictureView = MMLStatusPictureView()
    
}

// MARK: - UICollectionViewDataSource
extension MMLProductCommentCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: DDProductCommentsImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: String.init(describing: DDProductCommentsImageCell.self), for: indexPath) as! DDProductCommentsImageCell
        cell.contentView.backgroundColor = UIColor.white
        cell.productImageView.jq_setImage(imageUrl: kPrefixLink + images[indexPath.item], placeholder: "http_error")
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate
extension MMLProductCommentCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let _ = delegate {
            let tempImags = images.map{ kPrefixLink + $0}
            delegate?.viewCommentImages(contentImags: tempImags, currentIndex: indexPath.item)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MMLProductCommentCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // 如果使用浮点型 会出现莫名的间距
        let itemWH = Int((collectionView.width - 10) / 3.0)
        return CGSize.init(width: itemWH, height: itemWH)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    
    // 设置水平间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
}
