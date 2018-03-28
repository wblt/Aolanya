//
//  DDBaseWebViewVC.swift
//  Mythsbears
//
//  Created by HJQ on 2017/9/30.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import WebKit

class DDBaseWebViewVC: DDBaseViewController {
    
    
    fileprivate var loadURLString: String!
    fileprivate var navTitle = ""
    private var contentStr: String = ""
    fileprivate var loadCount: Float = 0.0 {
        didSet {
            updateProgress()
        }
    }
    
    // webView加载完成后的高度
    var webViewHeight: CGFloat = 0
    var webView: WKWebView!
    
    // MARK: - lift cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = navTitle
        if navTitle.isEmpty {
            self.navigationItem.title = "加载中..."
        }
        
        setupWKWebView()
        setupWebView()
        view.addSubview(progressView)
        
    }

    
    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
    
    private func setupWKWebView() {
        let config = WKWebViewConfiguration()
        config.userContentController = userContentController
        let rect = CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height - kStatusBarH - kNavigationBarH)
        webView = WKWebView.init(frame: rect, configuration: config)
        webView.navigationDelegate = self
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: NSKeyValueObservingOptions.new, context: nil)
        view.addSubview(webView)
    }
    
    
    // MARK: - lazy load
    lazy var userContentController: WKUserContentController = {[weak self] in
        let userContent = WKUserContentController()
        let jScript = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);"
        let wkUScript = WKUserScript.init(source: jScript, injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: true)
        userContent.addUserScript(wkUScript)
        let delegateController = DDWKWebViewDelegateVC()
        delegateController.delegate = self
        userContent.add(delegateController, name: "DigitalCampusWebApp")
        return userContent
        }()
    
    // 进度条
    fileprivate var progressView: UIProgressView = {
        let progressView = UIProgressView(frame: CGRect(x: 0, y: 0, width: Screen.width, height: 0))
        progressView.progressTintColor = UIColor.init(r: 251, g: 101, b: 71)
        progressView.trackTintColor = UIColor.white
        return progressView
    }()
    
    
    
}

extension DDBaseWebViewVC {
    
    /**
     加载连接
     
     - parameter urlString: 连接
     */
    func loadUrlString(_ urlString: String, title: String) {
        
        loadURLString = urlString
        navTitle = title
    }
    
    // 加载带网页标签的内容
    func loadContent(contentStr: String?) {
        if let _ = contentStr {
            self.contentStr = contentStr!
        }else {
            debugLog("webView的内容为空")
        }
    }
    
    
    /**
     加载本地网页
     
     - parameter localFileName: 文件名
     */
    func loadLocalFileName(_ localFileName: String) {
        if let path = Bundle.main.path(forResource: localFileName, ofType: "html") {
            
            do {
                let htmlContent = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
                
                let baseURL = NSURL(fileURLWithPath: path)
                webView.loadHTMLString(htmlContent, baseURL: baseURL as URL)
                
            }catch let error {
                
                debugLog("\(error)")
            }
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "estimatedProgress" {
            
            if let newprogress = change?[NSKeyValueChangeKey.newKey] as? Double {
                
                if (newprogress == 1) {
                    progressView.isHidden = true
                    progressView.setProgress(0, animated: false)
                }else {
                    progressView.isHidden = false
                    progressView.setProgress(Float(newprogress), animated: true)
                }
            }
        }
    }
}

// MARK: - WKNavigationDelegate methods
extension DDBaseWebViewVC: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        loadCount += 1
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        loadCount -= 1
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        loadCount -= 1
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        webViewHeight = webView.scrollView.contentSize.height
        
        if navTitle.isEmpty {
            setNavagationBar()
        }
        
        // 禁用webview长按功能
        webView.evaluateJavaScript("document.documentElement.style.webkitUserSelect='none';", completionHandler: nil)
        webView.evaluateJavaScript("document.documentElement.style.webkitTouchCallout='none';", completionHandler: nil)
        
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if let url = webView.url?.absoluteString, url.hasPrefix("https://itunes.apple.com") {
            
            UIApplication.shared.openURL(NSURL(string: url)! as URL)
            decisionHandler(WKNavigationActionPolicy.cancel)
        }else{
            
            decisionHandler(WKNavigationActionPolicy.allow)
        }
    }
    
}

// MARK: - DDWKWebViewDelegateVCDelegate methods
extension DDBaseWebViewVC: DDWKWebViewDelegateVCDelegate {
    // NativeMethod
    // js 调用下面这个方法才会走 window.webkit.messageHandlers.NativeMethod.postMessage("我要调用native的方法")
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
        
        if message.name == "DigitalCampusWebApp" {
            
            debugLog("\(message.body)")
            
            if let body = message.body as? String,
                let dic = body.toData()?.toDictionary(),
                let content = dic["content_url"] as? String,
                let method = dic["method"] as? String {
                
                if method == "detail" {
                    
                    //    NavigationManager.pushToWebView(form: self, url: content)
                } else if method == "phone" {
                    
                    BFunction.shared.showAlert(title: "是否拨打电话?", subTitle: content, ontherBtnTitle: "拨打", ontherBtnAction: {
                        
                    })
                }
            }
        }
        
        
    }
}

// MARK: - getters、setters
extension DDBaseWebViewVC {
    
    /**
     设置标题
     */
    fileprivate func setNavagationBar() {
        
        webView.evaluateJavaScript("document.title", completionHandler: { [weak self] (obj, error) in
            
            if let pageTitle = obj as? String {
                
                self?.navigationItem.title = pageTitle
            }
        })
    }
    
    fileprivate func setupWebView() {
        
        if loadURLString != nil && !loadURLString.isEmpty  {
            
            let request = URLRequest(url: NSURL(string: loadURLString)! as URL)
            webView.load(request)
        }
        
        if !contentStr.isEmpty {
            webView.loadHTMLString(contentStr, baseURL: nil)
        }
    }
    
    
    fileprivate func updateProgress() {
        
        debugLog(loadCount)
        
        if loadCount == 1.0 {
            progressView.isHidden = true
            progressView.setProgress(0, animated: false)
        }else{
            //            _progressView.isHidden = false
            //
            //            let oldP = _progressView.progress
            //            var newP = (1.0 - oldP) / (loadCount + 1) + oldP
            //
            //            if newP > 0.95 {
            //                newP = 0.95
            //            }
            //
            //            _progressView.setProgress(newP, animated: false)
        }
    }
    
}

