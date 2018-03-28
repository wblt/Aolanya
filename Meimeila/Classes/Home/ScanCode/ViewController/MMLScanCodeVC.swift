//
//  MMLScanCodeVC.swift
//  Meimeila
//
//  Created by HJQ on 2017/10/21.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import AVFoundation

private let scanAnimationDuration = 3.0//扫描时长

class MMLScanCodeVC: DDBaseViewController {
    
    //MARK: -
    //MARK: Global Variables
    
    var scanPane: UIImageView!///扫描框
    var activityIndicatorView: UIActivityIndicatorView!
    var bottomView:UIView?
    
    private let output = AVCaptureMetadataOutput()
    private var scanPreviewLayer: AVCaptureVideoPreviewLayer!
    
    var lightOn = false///开光灯
    
    
    //MARK: -
    //MARK: Lazy Components
    
    lazy var scanLine : UIImageView =
        {
            
            let scanLine = UIImageView()
            scanLine.frame = CGRect(x: 0, y: 0, width: self.scanPane.bounds.width, height: 3)
            scanLine.image = UIImage(named: "QRCode_ScanLine")
            
            return scanLine
            
    }()
    
    var scanSession :  AVCaptureSession?

    init() {
        super.init(nibName: String.init(describing: MMLScanCodeVC.self), bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        startScan()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "扫码"

    }
    
    override func setupUI() {
        initSubViews()
        setupScanSession()
    }
    
    // MARK: - Private methods
    private func initSubViews() {
        
        let label: UILabel = UILabel.init()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        label.text = "将取景框对准二维/条形码，即可自动扫描"
        self.view.addSubview(label)

        
        scanPane = UIImageView.init(image: UIImage.init(named: "QRCode_ScanBox"))
        self.view.addSubview(scanPane)
        scanPane.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 200, height: 200))
        }
        
        label.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(scanPane.snp.top).offset(-25)
        }
        
        activityIndicatorView = UIActivityIndicatorView.init()
        activityIndicatorView.color = UIColor.orange
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView!.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        view.layoutIfNeeded()
        scanPane.addSubview(scanLine)

    }
    
    //MARK: -
    //MARK: Interface Components
    
    func setupScanSession()
    {
        //设置捕捉设备
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else {return}
        //设置设备输入输出
        // TODO: 暂时不能再模拟器上运行
        guard let input = try? AVCaptureDeviceInput.init(device: device) else {return}
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        //设置会话
        let  scanSession = AVCaptureSession()
        scanSession.canSetSessionPreset(AVCaptureSession.Preset.high)
        
        if scanSession.canAddInput(input)
        {
            scanSession.addInput(input)
        }
        
        if scanSession.canAddOutput(output)
        {
            scanSession.addOutput(output)
        }
        
        //设置扫描类型(二维码和条形码)
        output.metadataObjectTypes = [
            AVMetadataObject.ObjectType.qr,
            AVMetadataObject.ObjectType.code39,
            AVMetadataObject.ObjectType.code128,
            AVMetadataObject.ObjectType.code39Mod43,
            AVMetadataObject.ObjectType.ean13,
            AVMetadataObject.ObjectType.ean8,
            AVMetadataObject.ObjectType.code93]
        
        //预览图层
        scanPreviewLayer = AVCaptureVideoPreviewLayer(session:scanSession)
        scanPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        //AVLayerVideoGravity.resizeAspectFillAVLayerVideoGravity.resizeAspectFill
        scanPreviewLayer.frame = view.layer.bounds
        
        view.layer.insertSublayer(scanPreviewLayer, at: 0)
        
        //设置扫描区域
        NotificationCenter.default.addObserver(self, selector: #selector(notiAction), name: NSNotification.Name.AVCaptureInputPortFormatDescriptionDidChange, object: nil)
        
        //保存会话
        self.scanSession = scanSession

        
    }
    
    // MARK: - Event respose
    @objc func notiAction() {
        output.rectOfInterest = (scanPreviewLayer.metadataOutputRectConverted(fromLayerRect: (self.scanPane.frame)))
    }
    
    //MARK: -
    //MARK: Private Methods
    
    //开始扫描
    fileprivate func startScan()
    {
        
        scanLine.layer.add(scanAnimation(), forKey: "scan")
        
        guard let scanSession = scanSession else { return }
        
        if !scanSession.isRunning
        {
            scanSession.startRunning()
        }
        
        
    }
    
    //扫描动画
    private func scanAnimation() -> CABasicAnimation
    {
        
        let startPoint = CGPoint(x: scanLine .center.x  , y: 1)
        let endPoint = CGPoint(x: scanLine.center.x, y: scanPane.bounds.size.height - 2)
        
        let translation = CABasicAnimation(keyPath: "position")
        translation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        translation.fromValue = NSValue(cgPoint: startPoint)
        translation.toValue = NSValue(cgPoint: endPoint)
        translation.duration = scanAnimationDuration
        translation.repeatCount = MAXFLOAT
        translation.autoreverses = true
        
        return translation
    }
    
    
    //MARK: -
    //MARK: Dealloc
    
    deinit
    {
        ///移除通知
        NotificationCenter.default.removeObserver(self)
        
    }


}

extension MMLScanCodeVC: AVCaptureMetadataOutputObjectsDelegate {
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!)
    {
        
        //停止扫描
        self.scanLine.layer.removeAllAnimations()
        self.scanSession!.stopRunning()
        
        //播放声音
        Tool.playAlertSound(sound: "noticeMusic.caf")
        
        //扫完完成
        if metadataObjects.count > 0
        {
            
            if let resultObj = metadataObjects.first as? AVMetadataMachineReadableCodeObject
            {
                
                let VC = MMLContentDetailsVC()
                VC.loadUrlString(resultObj.stringValue ?? " ", title: "")
                navigationController?.pushViewController(VC, animated: true)
                
                self.startScan()
//                Tool.confirm(title: "扫描结果", message: resultObj.stringValue, controller: self,handler: { (_) in
//                    //继续扫描
//                    self.startScan()
//                })
                
            }
            
        }
        
    }
}
