//
//  DDProductAddOrSubtractView.swift
//  ChartDemo
//
//  Created by HJQ on 2017/9/24.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

@objc protocol DDProductAddOrSubtractViewDlegate {
    // 商品数量增加
    func productAddOrSubtractViewDeincrease(textField: UITextField, deincreaseButton: UIButton)
    // 商品数量减少
    func productAddOrSubtractViewIncrease(textField: UITextField, increasButton: UIButton)
    // 通过直接输入的回调
    func productAddOrSubtractViewEnterNumber(number: Int)
    // 返回快速变化的结果 type 0 减少 1 增加
    func productAddOrSubtractViewFastChange(type: Int, number: Int)
}

public  enum DDProductAddOrSubtractViewStatus: Int {
    case productDeincreaseType = 0
    case productIncreaseType = 1
}

@IBDesignable public class DDProductAddOrSubtractView: UIView {
    
    weak var delegate: DDProductAddOrSubtractViewDlegate?
    
    fileprivate var currenSlectedButton: UIButton?
    
    // 只允许缓慢的增减
    fileprivate var isSlowIncreaseOrDecrease: Bool = true

    // 允许按钮长按数量快速增加
    @IBInspectable var isFastIncreaseOrDecrease: Bool = true
    
    // 是否允许操作
    @IBInspectable var isAllowTheOperation: Bool = true
    
    // 减少按钮的图片
    @IBInspectable var deincreaseImage: UIImage!{
        didSet {
            decreaseButton.setImage(deincreaseImage, for: .normal)
            decreaseButton.setImage(deincreaseImage, for: .highlighted)
        }
    }
    
    // 增加按钮的图片
    @IBInspectable var increaseImage: UIImage!{
        didSet {
            increaseButton.setImage(increaseImage, for: .normal)
            increaseButton.setImage(increaseImage, for: .highlighted)
        }
    }
    
    // 减少按钮的背景色
    @IBInspectable var deincreaseBackgroudColor: UIColor = UIColor.white{
        didSet {
            decreaseButton.backgroundColor = deincreaseBackgroudColor
        }
    }
    
    // 增加按钮的背景色
    @IBInspectable var increaseBackgroudColor:  UIColor = UIColor.white{
        didSet {
            increaseButton.backgroundColor = increaseBackgroudColor
        }
    }
    
    // 圆角
    @IBInspectable var cornerRadius: CGFloat = 3 {
        didSet {
            layer.masksToBounds = true
            layer.cornerRadius = cornerRadius
        }
    }
    
    // 边框大小
    @IBInspectable var bordWidth:  CGFloat = 1{
        didSet {
            layer.borderWidth = bordWidth
        }
    }
    
    // 边框颜色
    @IBInspectable var bordColor:  UIColor = UIColor.lightGray{
        didSet {
            layer.borderColor = bordColor.cgColor
        }
    }
    
    // 分割线的颜色
    @IBInspectable var lineColor: UIColor = UIColor.lightGray{
        didSet {
            rightLineView.backgroundColor = lineColor
            leftLineView.backgroundColor = lineColor
        }
    }
    
    // 分割线的宽度
    @IBInspectable var leftLineWidth: Double = 1{
        didSet {
            leftLineView.bounds.size.width = CGFloat(leftLineWidth)
        }
    }
    
    @IBInspectable var rightLineWidth: Double = 1{
        didSet {
            rightLineView.bounds.size.width = CGFloat(rightLineWidth)
        }
    }
    
    // MARK: - systen methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    //init方法
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupUI()
    }
    
    override public func awakeFromNib() {
        setupUI()
    }
    
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        adjustLayout()
    }
    
    deinit {
        cleanTimer()
    }
    
    // MARK: - Public method
    // 提供外面设置TextField的初始化值
    func setStartNumber(number: Int) {
        textField.text = "\(number)"
    }
    
    
    // MARK: - Private methods
    private func setupUI() {
        addSubview(leftLineView)
        addSubview(rightLineView)
        addSubview(textField)
        addSubview(decreaseButton)
        addSubview(increaseButton)
        
        setupButtonAction(button: decreaseButton)
        setupButtonAction(button: increaseButton)
    }
    
    private func adjustLayout() {
        let viewH: Double = Double(bounds.size.height)
        let viewW: Double = Double(bounds.size.width)
        
        leftLineView.frame = CGRect.init(x: viewH, y: 0.0, width: leftLineWidth, height: viewH)
        rightLineView.frame = CGRect.init(x: viewW - viewH - rightLineWidth, y: 0.0, width: rightLineWidth, height: viewH)
        increaseButton.frame = CGRect.init(x: viewW - viewH, y: 0, width: viewH, height: viewH)
        decreaseButton.frame = CGRect.init(x: 0, y: 0, width: viewH, height: viewH)
        textField.frame = CGRect.init(x: viewH, y: 0, width: viewW - 2 * viewH, height: viewH)
    }
    
    private func setupButtonAction(button: UIButton) {
        button.addTarget(self, action: #selector(buttonTouchDown(button:)), for: .touchDown)
        button.addTarget(self, action: #selector(buttonTouchUp(button:)), for: .touchUpInside)
        button.addTarget(self, action: #selector(buttonTouchUp(button:)), for: .touchUpOutside)
        button.addTarget(self, action: #selector(buttonTouchUp(button:)), for: .touchCancel)
    }
    
    // MARK: - Private methods
    @objc func buttonTouchDown(button: UIButton) {
        currenSlectedButton = button
        textField.resignFirstResponder()
        cleanTimer()
        
        if !isAllowTheOperation {
            return
        }
        
        if button == increaseButton {
            if isFastIncreaseOrDecrease {
                timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(increase), userInfo: nil, repeats: true)
            }else {
                increase()
            }

        }else {
            if isFastIncreaseOrDecrease {
                timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(decrease), userInfo: nil, repeats: true)
            }else {
                decrease()
            }

        }
    }
    
    @objc func buttonTouchUp(button: UIButton) {
        // 松手之后可以继续点击
        button.isUserInteractionEnabled = true
        isSlowIncreaseOrDecrease = true
        cleanTimer()
        
        // 返回快速变化的结果
        if let _ = currenSlectedButton {
            let newNum = Int(textField.text!)!
            var type: Int!
            if currenSlectedButton == increaseButton {
                type = DDProductAddOrSubtractViewStatus.productDeincreaseType.rawValue
            }else {
                type =  DDProductAddOrSubtractViewStatus.productIncreaseType.rawValue
            }
            if let _ = delegate {
               delegate?.productAddOrSubtractViewFastChange(type: type, number: newNum)
            }
        }
    }
    
    // 增加
    @objc func increase() {
        if textField.text?.count == 0 {
            textField.text =  "1"
        }
        
        if !isFastIncreaseOrDecrease {
            if !isSlowIncreaseOrDecrease {
                return
            }
            isSlowIncreaseOrDecrease = false
        }
        let newNum = Int(textField.text!)!
            //+ 1
        textField.text = "\(newNum)"
        if let _ = delegate {
            delegate?.productAddOrSubtractViewIncrease(textField: textField, increasButton: increaseButton)
        }
        
    }
    
    // 减少
    @objc func decrease() {
        if textField.text?.count == 0 {
            textField.text =  "1"
        }
        var newNum = Int(textField.text!)!
            //- 1
        if newNum <= 0 {
            newNum = 1
        }
        
        if !isFastIncreaseOrDecrease {
            if !isSlowIncreaseOrDecrease {
                return
            }
            isSlowIncreaseOrDecrease = false
        }

        textField.text = "\(newNum)"
        if let _ = delegate {
           delegate?.productAddOrSubtractViewDeincrease(textField: textField, deincreaseButton: increaseButton)
        }
       
    }
    
    
    // 监听文本的变化
    @objc func textFieldTextChange(tf: UITextField) {
        if tf.text?.count == 0 {
            
        }else {
            let newNum = Int(textField.text!)!
            if newNum == 0 {
                tf.text = ""
            }
        }

    }
    
    
    // 清除定时器
    private func cleanTimer() {
        if let _ = timer {
            timer?.invalidate()
            timer = nil
        }
    }
    
    
    // MARK: - lazy load
    // 定时器
    private var timer: Timer?
    
    private lazy var decreaseButton: UIButton = {
        let button = UIButton.init(type: .custom)
        return button
    }()
    
    private lazy var increaseButton: UIButton = {
        let button = UIButton.init(type: .custom)
        return button
    }()
    
    fileprivate lazy var textField: UITextField = {
        let textField = UITextField.init()
        textField.keyboardType = UIKeyboardType.numberPad
        textField.textAlignment = .center
        textField.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.text = "1"
        textField.addTarget(self, action: #selector(textFieldTextChange(tf:)), for: .editingChanged)
        textField.delegate = self
        return textField
    }()
    
    private lazy var leftLineView: UIView = {
        let view = UIView.init()
        view.backgroundColor = UIColor.init(red: 150/255.0, green: 150/255.0, blue: 150/255.0, alpha: 1)
        return view
    }()
    
    private lazy var rightLineView: UIView = {
        let view = UIView.init()
        view.backgroundColor = UIColor.init(red: 150/255.0, green: 150/255.0, blue: 150/255.0, alpha: 1)
        return view
    }()

}

extension DDProductAddOrSubtractView: UITextFieldDelegate {
    // 禁止操作
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
            // isAllowTheOperation ? true : false
    }
    
    // 结束编辑的时候调用
    public func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.count == 0 {
            textField.text =  "1"
        }
        let newNum = Int(textField.text!)!
        textField.text = "\(newNum)"
        if let _ = delegate {
            delegate?.productAddOrSubtractViewEnterNumber(number: newNum)
        }
    }
    
}
