//
//  DDCountDownButton.swift
//  Mythsbears
//
//  Created by HJQ on 2017/9/30.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class DDCountDownButton: UIButton {

    var validcodeTimer:Timer!
    var eclipsedSeconds:Int!
    var eclipsingSeconds:Int!
    var isFetchedSuccess:Bool!
    var isVerifySuccess:Bool!
    var originalBgColor:UIColor!  = UIColor.RGB("#fe6528")
    var notActiveBgColor:UIColor! = UIColor.RGB("#fe6528")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initUI()
    }
    
    func initUI() {
        
        
        //默认60秒
        self.setCornerBorderWithCornerRadii(self.frame.height / 2, width: 0.5, color: originalBgColor)
        self.setTitleColor(originalBgColor, for: .normal)
        eclipsedSeconds = 60
        isFetchedSuccess = false
        isVerifySuccess = false
        
    }
    func eclipseTime(seconds:Int){
        eclipsedSeconds = seconds
    }
    
    
    func startEclipse(){
        if (validcodeTimer == nil) {
            eclipsingSeconds = eclipsedSeconds
            self.isEnabled = false
            self.eclipseBySeconds()
            validcodeTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(DDCountDownButton.eclipseBySeconds), userInfo: nil, repeats: true)
        }
        
        //self.layer.backgroundColor = notActiveBgColor.cgColor
        
        //让其变成灰色
    }
    
    
    /**
     * @brief 是否已点击获取验证码
     */
    
    func isFetchedValidCode() -> Bool {
        return isFetchedSuccess
    }
    
    func fetchedCodeSuccess() {
        isFetchedSuccess = true
    }
    
    /*! @breif 判断验证码是否验证成功 */
    
    func isVerifyCodeSuccess() -> Bool {
        return isVerifySuccess
    }
    
    /*! @breif 验证码已验证成功 */
    
    func verifySuccess(success: Bool) {
        isVerifySuccess = success
        if !success {
            self.stopEclipse()
        }
    }
    
    @objc func eclipseBySeconds() {
        if eclipsingSeconds > 1 {
            self.setTitle("等待\(eclipsingSeconds!)秒", for: .disabled)
            eclipsingSeconds = eclipsingSeconds - 1
        }
        else {
            self.stopEclipse()
        }
    }
    
    func stopEclipse() {
        validcodeTimer.invalidate()
        self.isEnabled = true
        validcodeTimer = nil
        // self.layer.borderWidth = 1
        
        // self.setTitleColor(UIColorHex("FFFFFF"), forState: UIControlState.Normal)
        //self.layer.borderColor = UIColorHex("#FFFFFF").CGColor
        //self.layer.backgroundColor = originalBgColor.cgColor
    }
    
    func buttonPressed(_ sender: UIButton) {
        self.startEclipse()
    }


}
