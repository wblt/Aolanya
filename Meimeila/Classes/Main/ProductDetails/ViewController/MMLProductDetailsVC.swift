//
//  MMLProductDetailsVC.swift
//  Meimeila
//
//  Created by HJQ on 2017/10/17.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import FSPagerView
import Kingfisher
import AVFoundation

class MMLProductDetailsVC: DDBaseViewController {

    var shoppingID: String!
    
    // 广告相关
    @IBOutlet weak var bannerBGView: UIView!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var headerBGHeightCons: NSLayoutConstraint!

    
    // 商品信息
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productDescLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var redPButton: UIButton!
    
    
    // 商品评价信息
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var commentTableView: UITableView!
    @IBOutlet weak var contentHeightCons: NSLayoutConstraint!
    // 市场价
    @IBOutlet weak var markPriceLabel: UILabel!
    
    // 商品详情
    @IBOutlet weak var webDetailsBGView: UIView!
    @IBOutlet weak var webDetailsHeightCons: NSLayoutConstraint!
    
    // 收藏按钮
    @IBOutlet weak var collectionButton: DDVerticalButton!
    
    // 购物车按钮
    @IBOutlet weak var shoppingCartButton: DDVerticalButton!
    
    // 轮播图链接
    var bannerImages: [String] =  [String]()
    // 评论信息
    var evaluateData: MMLProductDetailsEvaluateData?
    // 商品介绍
    var introduceImgs: [String] = [String]()
    private let preloadHeight: CGFloat = 400
    private var totalHeight: CGFloat = 0
    
    // 播放领取红包的声音
    private var audioPlay: AVAudioPlayer!
    
    
    init() {
        super.init(nibName: String.init(describing: MMLProductDetailsVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //navigationController?.setNavigationBarHidden(true, animated: false)
      //  requestQueryGoodsIsCollectionData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewBindEvents()
        requestProductDeatailsData()

    }
    
    override func setupUI() {
        setupNavBar()
        setupCommentTableView()
        bannerBGView.addSubview(homeBannerView)
        homeBannerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    
        webDetailsBGView.addSubview(introduceTableView)
        introduceTableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        
    }
    
    // MARK: - Private methods
    private func setupCommentTableView() {
        commentTableView.tableFooterView = UIView.init()
        commentTableView.separatorStyle = .none
        commentTableView.isScrollEnabled = false
        commentTableView.delegate = self
        commentTableView.dataSource = self
        commentTableView.register(UINib.init(nibName: String.init(describing: MMLProductCommentCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: MMLProductCommentCell.self))
    }
    
    // 设置导航栏
    private func setupNavBar() {
        addNavBarRightButton(imageName: "productdetails_shopping_message") { [weak self](btn) in
            let VC = MMLShareVC()
            VC.delegate = self
            VC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            self?.present(VC, animated: false, completion: nil)
        }
    }
    
    private func viewBindEvents() {
        let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(viewCommentsAction))
        commentView.addGestureRecognizer(tapGes)
    }
    

    // 请求商品详情数据
    private func requestProductDeatailsData() {
        productDetailsViewModel.getProductDetails(shoppingID: shoppingID, successBlock: {[weak self] in
            self?.setupProductDeatailsData()
            
        }) {[weak self] in
            self?.setupProductDeatailsData()
        }
    }
    
    // 设置数据
    private func setupProductDeatailsData() {
        // 设置广告数据
        var bannerDatas = [String]()
        productDetailsViewModel.productDetailsModel?.banner.forEach({ (banner) in
            bannerDatas.append(kPrefixLink + banner.shoppingBannerImg)
        })
        
        // 广告图数据
        bannerImages = bannerDatas
        if bannerDatas.count == 0 {
            numberLabel.isHidden = true
            numberLabel.text = "0/\(bannerDatas.count)"
        }else{
            numberLabel.isHidden = false
            numberLabel.text = "1/\(bannerDatas.count)"
        }
        homeBannerView.reloadData()
        
        // 设置商品数据
        let shoppingData = productDetailsViewModel.productDetailsModel?.shoppingData
        productNameLabel.text = shoppingData?.shopingName
        productDescLabel.text = shoppingData?.shopingMessage
        productPriceLabel.text = "￥" + "\(shoppingData?.price! ?? 0.00)"
        markPriceLabel.text = "￥" + "\(shoppingData?.market_value! ?? 0.00)"
        markPriceLabel.sizeToFit()
        redPButton.isHidden = shoppingData?.discount == 1 ? false : true
		collectionButton.isSelected = shoppingData?.totalCollection == "1" ?true:false
		//设置小红点
		let number = shoppingData?.shoppingCartNumber
		if number != "0" {
			shoppingCartButton.showRedpointOffset(x: 40, y: 3, value: number)
			DDShoppingCarTool.shared.shakeAnimation(shakeView: (shoppingCartButton.imageView)!)
			shoppingCartButton.resumeAnimate()
		}
		
		
        // 设置评论信息
        evaluateData = productDetailsViewModel.productDetailsModel?.evaluateData
        if let _ = evaluateData {
            commentCountLabel.text = "用户评价(" + evaluateData!.fabulous + ")"
            var images = (evaluateData?.evaluateImg.components(separatedBy: ","))!
            if evaluateData?.evaluateImg == "" {
                images.removeAll()
            }
            let column = 3
            let row = images.count % column == 0 ? images.count / column : (images.count / column) + 1
            let itemWH = (UIScreen.main.bounds.width - 30 - 10) / 3.0
            let collectionViewH =  CGFloat(Int(itemWH) * row + (5 * (row)))
            contentHeightCons.constant = 96.0 + collectionViewH
        }else {
            commentCountLabel.text = "用户评价(" + "0" + ")"
            contentHeightCons.constant = 0
        }
        commentTableView.reloadData()
        
        // 设置商品详情
        let introduce = productDetailsViewModel.productDetailsModel?.shoppingIntroduce
        if let _ = introduce {
            for data in introduce! {
                introduceImgs.append(kPrefixLink + data.introduceImg)
            }
            totalHeight = CGFloat(CGFloat(introduceImgs.count) * preloadHeight)
            //webDetailsHeightCons.constant = CGFloat(introduceImgs.count * 400)
            introduceTableView.reloadData()
        }
		
		// 设置是否收藏
        
    }
    
    
    // 收藏商品
    private func requestAddProductCollectionData() {
        productDetailsViewModel.addProductCollection(shoppingID: shoppingID) { [weak self] in
            self?.collectionButton.isSelected = true
            BFunction.shared.collectionAnimation(button: (self?.collectionButton)!)
        }
    }
    
    // 取消商品收藏
    private func requestCancelProductCollectionData() {
        productDetailsViewModel.cancelProductCollection(shoppingID: shoppingID) {[weak self] in
            self?.collectionButton.isSelected = false
            BFunction.shared.collectionAnimation(button: (self?.collectionButton)!)
        }
    }
    
    // 添加商品到购物车
    private func requestAddProductToCar() {
        productDetailsViewModel.productIncrease(shoppingID: shoppingID, number: "1") {[weak self] in
            //debugLog("添加成功")
            if let _ = self?.productDetailsViewModel.addCarModel {
                let number = self?.productDetailsViewModel.addCarModel!.shoppingCartNumber ?? 0
                self?.shoppingCartButton.showRedpointOffset(x: 40, y: 3, value: "\(number)")
                DDShoppingCarTool.shared.shakeAnimation(shakeView: (self?.shoppingCartButton.imageView)!)
                self?.shoppingCartButton.resumeAnimate()
            }
            
        }
        
    }
    
    // 查询商品是否已经收藏
    private func requestQueryGoodsIsCollectionData() {
        productDetailsViewModel.queryGoodIsCollection(shoppingID: self.shoppingID, successBlock: {[weak self] in
            self?.collectionButton.isSelected = self?.productDetailsViewModel.iscollect == 1 ? true : false
            let count = self?.productDetailsViewModel.shoppingCarNumber
            if count == 0 {
                self?.shoppingCartButton.removeRedpoint()
            }else {
                self?.shoppingCartButton.showRedpointOffset(x: 35, y: 1, value: String.init(format: "%ld", count!))
                self?.shoppingCartButton.resumeAnimate()
            }
        }) { [weak self](status) in
            self?.shoppingCartButton.removeRedpoint()
        }
    }
    
    // 领取红包
    private func requestRedEnvelopeData() {
        useRedPacketsViewModel.receiveRedEnvelope(shoppingID: shoppingID) { [weak self](money) in
            self?.playMusic()
            let VC = MMLRedenvelopePopupVC()
            VC.money = money
            VC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            self?.present(VC, animated: false, completion: nil)
        }
    }
    
    //    必须要用 AVAudioSession，否则木有声音啊。
    //    不要把 AVAudioPlayer 当做局部变量（具体说在这个例子中，不要在 viewDidLoad 中定义）。
    //    要找好路径，这里用 mainBundle，不要搞错。
    private func playMusic() {
        
        let musicPath = Bundle.main.path(forResource: "money", ofType: "mp3")
        let fileUrl = NSURL.fileURL(withPath: musicPath ?? " ")
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSessionCategoryPlayback)
            try session.setActive(true)
            audioPlay = try AVAudioPlayer.init(contentsOf: fileUrl)
            audioPlay.numberOfLoops = 0
            audioPlay.volume = 0.5
            audioPlay.currentTime = 0
            audioPlay.prepareToPlay()
            audioPlay.play()
        }
        catch {
            debugLog(error)
        }
    }
    
    // 是否需要登录
    private func checkInLogin() -> Bool{
        if !DDDeviceManager.shared.loginStatue() {
            let vc = MMLLoginVC()
            navigationController?.pushViewController(vc, animated: true)
            return true
        }
        return false
    }
    
    // MARK: - Eevent respose
    // 查看更多商品评论
    @objc func viewCommentsAction() {
        let VC = MMLViewCommentsVC()
        if let data =  productDetailsViewModel.productDetailsModel {
             VC.evaluateData = data.evaluateData
        }
        VC.shoppingID = shoppingID
        navigationController?.pushViewController(VC, animated: true)
    }
    
    // 收藏
    @IBAction func collectionAction(_ sender: Any) {
        if checkInLogin() {return}
        if collectionButton.isSelected {
            requestCancelProductCollectionData()
        }else {
            requestAddProductCollectionData()
        }
    }
    
    // 到购物车去
    @IBAction func gotoShoppingCartAction(_ sender: Any) {
        if checkInLogin() {return}
        navigationController?.pushViewController(MMLShoppingCartVC(), animated: true)
    }
    
    // 添加到购物车
    @IBAction func addToShoppingCartAction(_ sender: Any) {
        if checkInLogin() {return}
        requestAddProductToCar()
    }
    
    // 领取红包
    @IBAction func redPButtonAction(_ sender: Any) {
        if checkInLogin() {return}
        requestRedEnvelopeData()
    }
    
    // MARK: - Lazy load
    private lazy var homeBannerView: FSPagerView = {[weak self] in
        let  homeBannerV: FSPagerView = FSPagerView.init()
        homeBannerV.register(FSPagerViewCell.self, forCellWithReuseIdentifier: String.init(describing: FSPagerViewCell.self))
        // 是否开启循环
        homeBannerV.isInfinite = true
        homeBannerV.automaticSlidingInterval = 5.0
        homeBannerV.transformer =  FSPagerViewTransformer.init(type: .crossFading)
        homeBannerV.itemSize = CGSize.zero
        homeBannerV.delegate = self
        homeBannerV.dataSource = self
        return homeBannerV
    }()
    
    private lazy var introduceTableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView.isScrollEnabled = false
        tableView.separatorColor = .clear
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView.init()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = DDGlobalBGColor()
        tableView.register(UINib.init(nibName: String.init(describing: MMLProductIntroduceCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: MMLProductIntroduceCell.self))
        return tableView
    }()
    
    fileprivate lazy var productDetailsViewModel: DDProductDetailsViewModel = {
        let viewModel = DDProductDetailsViewModel()
        return viewModel
    }()
    
    private lazy var useRedPacketsViewModel: MMLUseRedPacketsViewModel = MMLUseRedPacketsViewModel()
}

/// 评价列表
// MARK: - UITableViewDelegate
extension MMLProductDetailsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == commentTableView {
            
            var images = (evaluateData?.evaluateImg.components(separatedBy: ","))!
            if evaluateData?.evaluateImg == "" {
                images.removeAll()
            }
            let column = 3
            let row = images.count % column == 0 ? images.count / column : (images.count / column) + 1
            let itemWH = (UIScreen.main.bounds.width - 30 - 10) / 3.0
            let collectionViewH =  CGFloat(Int(itemWH) * row + (5 * (row - 1)))
            return 96.0 + (collectionViewH > 0 ? collectionViewH : 0)
        }
        let urlStr = introduceImgs[indexPath.row]
        let image = KingfisherManager.shared.cache.retrieveImageInDiskCache(forKey: urlStr)
        if let _ = image {
            let w = image?.size.width ?? 0
            let h = image?.size.height ?? 0
            let rowHeight = UIScreen.main.bounds.size.width * h / w > 0 ?  UIScreen.main.bounds.size.width * h / w : 0
            // 解决带有小数有分割线的问题
            return ceil(rowHeight)
        }
        return preloadHeight
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if tableView == commentTableView {
            
        }else {
            // 查看图片
            MMLPhotoViewer.shared.viewImages(vc: self, images: introduceImgs, currentIndex: indexPath.row)
        }
    }
}

// MARK: - UITableViewDataSource
extension MMLProductDetailsVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView ==  commentTableView {
            if let _ = evaluateData {
                return 1
            }
            return 0
        }
        return introduceImgs.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == commentTableView {
            var cell: MMLProductCommentCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: MMLProductCommentCell.self)) as? MMLProductCommentCell
            if let _ = cell {
            }else {
                cell = Bundle.main.loadNibNamed(String.init(describing: MMLProductCommentCell.self), owner: nil, options: nil)?.first as? MMLProductCommentCell
            }
            cell?.selectionStyle = .none
            cell?.indexPath = indexPath
            cell?.delegate = self
            cell?.evaluateData = evaluateData
            cell?.shopFabulousButton.isHidden = true
            return cell!
        }else {
            var cell: MMLProductIntroduceCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: MMLProductIntroduceCell.self)) as? MMLProductIntroduceCell
            if let _ = cell {
            }else {
                cell = Bundle.main.loadNibNamed(String.init(describing: MMLProductIntroduceCell.self), owner: nil, options: nil)?.first as? MMLProductIntroduceCell
            }
            cell?.selectionStyle = .none
            cell?.delegate = self
            cell?.indexPath = indexPath
            cell?.imageUrlStr = introduceImgs[indexPath.row]
            //cell?.evaluateData = evaluateData
            return cell!
        }

    }
}

/// 分享
// MARK: - MMLShareVCDelegate
extension MMLProductDetailsVC: MMLShareVCDelegate {
    
    func shareModule(moduleType: UMShareType) {
        debugLog(moduleType)
        if moduleType == .wechat || moduleType == .wechatLine {
            if !DDWechatShare.shared.isWXAppInstalled() {
                BFunction.shared.showToastMessge("需安装微信客户端，才能使用该功能！")
                return
            }
        }
        // 分享
        var title = ""
        var content = ""
        var imageURL: String = "img"
        var downloadUrl = "http://ml.nnddkj.com/meimeila/API/download/appDownload.php"
        
        if let _ = self.productDetailsViewModel.productDetailsModel {
            if let data = self.productDetailsViewModel.productDetailsModel?.shoppingData {
                title = data.shopingName
                content = data.shopingMessage
                imageURL = kPrefixLink + data.shopingImg
                downloadUrl = "http://ml.nnddkj.com/meimeila/API/download/appDownload.php?shopingID=" + data.shopingID
            }
        }
        
        let imageData = NSData.init(contentsOf: URL.init(string: imageURL)!)
        var image = UIImage.init(named: "1024")
        if let _ = imageData {
            image = UIImage.init(data: imageData! as Data)!
            if let _ = image  {
            }else {
                image = UIImage.init(named: "1024")
            }
        }
        let model = MMLShareWebpageObject()
        model.title = title
        model.desStr = content
        model.webpageUrl = downloadUrl
        model.image = image
        MMLUMengShareTool.shared.showShareType(type: moduleType, object: model, currentViewController: self, shareSuccessBlock: {
            self.shareSuccess()
        }) {
            
        }
    }
}

// MARK: - 分享成功
extension MMLProductDetailsVC {
    
    private func shareSuccess() {
        let request = ShareAPI.shareSuccess()
        DDHTTPRequest.request(r: request, requestSuccess: { (result) in
            
        }, requestError: { (result, errorModel) in
            
        }) { (error) in
            
        }
    }
}

/// 轮播
// MARK:- FSPagerView DataSource
extension MMLProductDetailsVC: FSPagerViewDataSource {
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return bannerImages.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: String.init(describing: FSPagerViewCell.self), at: index)
        cell.contentMode = .scaleAspectFit
        cell.imageView?.jq_setImage(imageUrl: bannerImages[index])
        return cell
    }
}

// MARK:- FSPagerView Delegate
extension MMLProductDetailsVC: FSPagerViewDelegate {
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
        MMLPhotoViewer.shared.viewImages(vc: self, images: bannerImages, currentIndex: index)
    }
    
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        numberLabel.text = "\(pagerView.currentIndex + 1 )/\(bannerImages.count)"
        //self.fsPageViewControl.currentPage = pagerView.currentIndex // Or Use KVO with property "currentIndex"
    }
}


// MARK: - MMLProductIntroduceCellDelegate
extension MMLProductDetailsVC: MMLProductIntroduceCellDelegate {
    func introduceDownLoadFinish(indexPath: IndexPath) {
        let urlStr =  introduceImgs[indexPath.row]
        let image = KingfisherManager.shared.cache.retrieveImageInDiskCache(forKey: urlStr)
        var tempH: CGFloat = 0
        if let _ = image {
            let w = image?.size.width ?? 0
            let h = image?.size.height ?? 0
            // 当前cell的高度
            tempH = UIScreen.main.bounds.size.width * h / w  > 0 ?UIScreen.main.bounds.size.width * h / w : 0
            //debugLog("当前图片的高度\(tempH)")
        }else {
            tempH = preloadHeight
        }
        totalHeight = totalHeight - preloadHeight + tempH
        webDetailsHeightCons.constant = totalHeight
        //introduceTableView.reloadRows(at: [indexPath], with: .none)
    }
}

// 商品评价点赞和取消点赞
// MARK: - MMLProductCommentCellDelegate
extension MMLProductDetailsVC: MMLProductCommentCellDelegate {
    func productCommentCellShopFabulous(button: UIButton, currentIndex: Int) {
        if button.isSelected {
            productDetailsViewModel.delShopFabulous(shoppingID: shoppingID, evaluateID: (evaluateData?.evaluateID)! , successBlock: {
                button.isSelected = false
            })
        }else {
            productDetailsViewModel.addShopFabulous(shoppingID: shoppingID, evaluateID: (evaluateData?.evaluateID)!, successBlock: {
                button.isSelected = true
            })
        }
    }
    
    func viewCommentImages(contentImags: [String], currentIndex: Int) {
        MMLPhotoViewer.shared.viewImages(vc: self, images: contentImags, currentIndex: currentIndex)
    }
}
