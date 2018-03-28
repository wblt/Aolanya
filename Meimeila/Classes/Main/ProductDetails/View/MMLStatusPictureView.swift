//
//  MMLStatusPictureView.swift
//  Meimeila
//
//  Created by HJQ on 2017/10/19.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLStatusPictureView: UICollectionView {

    var images: [String]? {
        didSet {
            reloadData()
        }
    }
    
    
    private var pictureLayout: UICollectionViewFlowLayout =  UICollectionViewFlowLayout()
    init() {
        super.init(frame: CGRect.zero, collectionViewLayout: pictureLayout)
        register(MMLPictureViewCell.self, forCellWithReuseIdentifier: String.init(describing: MMLPictureViewCell.self))
        dataSource = self
        delegate = self
        
        // 2.设置cell之间的间隙
        pictureLayout.minimumInteritemSpacing = 10
        pictureLayout.minimumLineSpacing = 10
        
        // 3.设置配图的背景颜色
        backgroundColor = UIColor.darkGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /**
     计算配图的尺寸
     */
    func calculateImageSize() -> CGSize {
        
        // 1.取出配图个数
        let count = images?.count ?? 0
        // 2.如果没有配图 zero
        if count == 0 {
            return CGSize.zero
        }
        
        // 3.如果只有一张配图 // 直接返回图片大小
        if count == 1 {
            //let key = images?.first
            //pictureLayout.itemSize = image.size
            return CGSize.zero
        }
        
        // 4.如果有4张配图， 计算田字格大小
        let width = 90
        let margin = 10
        pictureLayout.itemSize = CGSize(width: width, height: width)
        if count == 4 {
            let viewWidth = width * 2 + margin
            return CGSize(width: viewWidth, height: viewWidth)
        }
        
        // 5.如果是其它(多张), 计算九宫格的大小
        // 5.1计算列数
        let colNumber = 3
        // 5.2计算行数
        let rowNumber = (count - 1) / 3 + 1
        // 宽度 = 列数 * 图片的宽度 + (列数 - 1) * 间隙
        let viewWidth = colNumber * width + (colNumber - 1) * margin
        // 高度 = 行数 * 图片的高度 + (行数 - 1) * 间隙
        let viewHeight = rowNumber * width + (rowNumber - 1) * margin
        return CGSize(width: viewWidth, height: viewHeight)
    }
    
}

// MARK: - UICollectionViewDataSource
extension MMLStatusPictureView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MMLPictureViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: String.init(describing: MMLPictureViewCell.self), for: indexPath) as! MMLPictureViewCell
        cell.imageStr = images?[indexPath.item]
        return cell
    }
    

}

// MARK: - UICollectionViewDelegate
extension MMLStatusPictureView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        debugLog(indexPath.item)
    }
}
