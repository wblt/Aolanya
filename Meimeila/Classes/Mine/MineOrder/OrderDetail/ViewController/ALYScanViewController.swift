//
//  ALYScanViewController.swift
//  Meimeila
//
//  Created by yanghuan on 2018/6/29.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import UIKit


class ALYScanViewController: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
	var sessionManager:AVCaptureSessionManager?
	var link: CADisplayLink?
	var torchState = false
	
	typealias qrCode = (String) -> ()
	var block: qrCode?
	
	func getBlock(block: qrCode?) {
		self.block = block
	}
	
	
	@IBOutlet weak var scanTop: NSLayoutConstraint!
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		link = CADisplayLink(target: self, selector: #selector(scan))
		self.navigationItem.title = "扫一扫";
		sessionManager = AVCaptureSessionManager(captureType: .AVCaptureTypeBoth, scanRect: CGRect.null, success: { (result) in
			if let r = result {
			 //	self .showResult(result: r)
				if let block = self.block {
					block(r)
					self.navigationController?.popViewController(animated: true);
				}
			}
		})
		sessionManager?.showPreViewLayerIn(view: view)
		sessionManager?.isPlaySound = true
		
		
    }
	
	override func viewWillAppear(_ animated: Bool) {
		link?.add(to: RunLoop.main, forMode: RunLoopMode.commonModes)
		sessionManager?.start()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		link?.remove(from: RunLoop.main, forMode: RunLoopMode.commonModes)
		sessionManager?.stop()
	}
	
	
	@objc func scan() {
		scanTop.constant -= 1;
		if (scanTop.constant <= -170) {
			scanTop.constant = 170;
		}
	}
	
	
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		sessionManager?.start()
		dismiss(animated: true, completion: nil)
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		dismiss(animated: true) {
			self.sessionManager?.start()
			self.sessionManager?.scanPhoto(image: info["UIImagePickerControllerOriginalImage"] as! UIImage, success: { (str) in
				if let result = str {
					self.showResult(result: result)
				}else {
					self.showResult(result: "未识别到二维码")
				}
			})
			
		}
	}
	
	func showResult(result: String) {
		let alert = UIAlertView(title: "扫描结果", message: result, delegate: nil, cancelButtonTitle: "确定")
		alert .show()
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
