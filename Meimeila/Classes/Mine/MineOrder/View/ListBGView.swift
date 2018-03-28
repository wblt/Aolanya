//
//  ListBGView.swift
//  Mythsbears
//
//  Created by macos on 2017/9/23.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class ListBGView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame);
        
        
        setUI();
        addjustLayOut();
     
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
  fileprivate  func setUI() {
    
    addSubview(listScrollView);
    
    }
    
  fileprivate  func addjustLayOut() {
    
    listScrollView.snp.makeConstraints { (make) in
        
        make.edges.equalToSuperview();

    }
    }
    
    
    fileprivate lazy var listScrollView:UIScrollView = {
    
        let sview = UIScrollView.init();
    
        let h = self.frame.height;
        sview.contentSize = CGSize.init(width: Screen.width * 4, height:h);
        sview.showsHorizontalScrollIndicator = true;
        sview.isScrollEnabled = true;
        sview.delegate = self;
        sview.backgroundColor = UIColor.white;
        sview.isUserInteractionEnabled = true;
        sview.isPagingEnabled = true;
        return sview;
    }()
    
    
    var indexPage:Int = 0;
    
}




extension ListBGView:UIScrollViewDelegate {

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
        
        
    }


}


extension ListBGView {
    
    
    func setPage(_ pageIndex:Int) {
        
        
        listScrollView.contentOffset = CGPoint.init(x: CGFloat(pageIndex) * Screen.width, y: 0);
        
        var page:ListView? = listScrollView.viewWithTag(pageIndex) as? ListView;
        
        
        if let _ = page{
        
        }else{
        
            page = ListView.init(frame: CGRect.init(x: Screen.width * CGFloat(pageIndex), y: 0, width: Screen.width, height: Screen.height - 64 - 44));
            listScrollView.addSubview(page!);
            page?.tag = pageIndex;
            
        }
    }
    

}
