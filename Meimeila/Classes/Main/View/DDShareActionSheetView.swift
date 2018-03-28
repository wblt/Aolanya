//
//  DDShareActionSheetView.swift
//  Mythsbears
//
//  Created by HJQ on 2017/9/21.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

fileprivate let kContentH = 300.0

typealias shareActionSheetViewBlock = (_ index: Int)->()

// 分享弹窗页面

class DDShareActionSheetView: UIView {
    

    fileprivate var block: shareActionSheetViewBlock!
    
    class func getShareActionSheetView() -> DDShareActionSheetView{
        let actionSheet = DDShareActionSheetView()
        actionSheet.frame = UIScreen.main.bounds
        actionSheet.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.6)
        let window = UIApplication.shared.keyWindow
        window?.addSubview(actionSheet)
        return actionSheet
    }
    
    // MARK: - public methods
    func show(result: @escaping shareActionSheetViewBlock) {
        block = result
        UIView.animate(withDuration: 0.3) {
            self.bgView.y = UIScreen.main.bounds.height - self.bgView.height
        }
    }
    
    // MARK: - system methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    // MARK: - Private methods
    private func setupUI() {
        
        addSubview(bgView)
        // 上部 分享界面
        bgView.addSubview(topView)
        // 分割线
        topView.addSubview(lineView)
        // 分享到 标签
        topView.addSubview(shareLabel)
        // 分享按钮的 view
        topView.addSubview(shareButtonView)
        // 取消按钮
        topView.addSubview(cancelButton)
        
        topView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        shareLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(15)
            make.height.equalTo(40)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.top.equalTo(35)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(1)
        }
        
        shareButtonView.snp.makeConstraints { (make) in
            make.top.equalTo(shareLabel.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(100)
        }
        
        // 取消按钮
        cancelButton.snp.makeConstraints { (make) in
            make.height.equalTo(35)
            make.left.equalTo(25)
            make.right.equalTo(-25)
            make.top.equalTo(shareButtonView.snp.bottom).offset(20)
        }
    }
    

    // MARK: - Lazy load
    // 背景View
    private lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: CGFloat(kContentH))
        return bgView
    }()
    
    // 主要内容View
    private lazy var topView: UIView = {
        let topView = UIView()
        topView.backgroundColor = UIColor.white
        topView.layer.cornerRadius = 0
        topView.layer.masksToBounds = true
        return topView
    }()
    
    // 分享给朋友
    private lazy var shareLabel: UILabel = {
        let shareLabel = UILabel()
        shareLabel.backgroundColor = UIColor.white
        shareLabel.text = "分享给朋友"
        shareLabel.textColor = UIColor.lightGray
        shareLabel.textAlignment = .center
        return shareLabel
    }()
    
    // 分享的按钮
    private lazy var shareButtonView: DDShareButtonView = {
        let shareButtonView = DDShareButtonView()
        shareButtonView.delegate = self
        return shareButtonView
    }()
    
    // 线
    private lazy var lineView: UIView = {
        let view = UIView.init()
        view.backgroundColor = DDGlobalBGColor()
        return view
    }()
    
    // 取消按钮
    private lazy var cancelButton: UIButton = {
        let cancelButton = UIButton()
        cancelButton.setTitle("取消", for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        cancelButton.setTitleColor(UIColor.lightGray, for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonClick), for: .touchUpInside)
        cancelButton.layer.cornerRadius = 20
        cancelButton.layer.masksToBounds = true
        cancelButton.layer.borderWidth = 1
        cancelButton.layer.borderColor = UIColor.lightGray.cgColor
        return cancelButton
    }()
    
    // MARK: - Action methods
    @objc func cancelButtonClick() {
        UIView.animate(withDuration: 0.3, animations: {
            self.bgView.y = UIScreen.main.bounds.height
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.bgView.y = UIScreen.main.bounds.height
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
  

}

// MARK: - DDShareButtonViewDelegate method
extension DDShareActionSheetView: DDShareButtonViewDelegate {
    func buttonSelectedIndex(index: Int) {
        block(index)
        cancelButtonClick()
    }
}
