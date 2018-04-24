//
//  MMLViewCommentsVC.swift
//  Meimeila
//
//  Created by HJQ on 2017/10/17.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

// 商品评价列表
class MMLViewCommentsVC: DDBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    // 商品评价数据，用来设置满意度
    var evaluateData: MMLProductDetailsEvaluateData?
    var shoppingID: String!
    
    // 满意度
    @IBOutlet weak var satisfactionLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    
    init() {
        super.init(nibName: String.init(describing: MMLViewCommentsVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "商品评价"
        viewBindEvents()
        requestEvalueListData()
        headerView.backgroundColor =  RGB_App_Green
        if let _ = evaluateData {
            satisfactionLabel.text = evaluateData?.score
        }
    }
    
    override func setupUI() {
        setupTableView()
        
    }
    
    // MARK: - Private methods
    private func setupTableView() {
        tableView.tableFooterView = UIView.init()
        tableView.separatorColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: String.init(describing: MMLProductCommentCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: MMLProductCommentCell.self))
        
    }
    
    // 添加上下拉刷新
    private func viewBindEvents() {
        setupRefresh(tableView,isNeedFooterRefresh:false, headerCallback: {[weak self] in
            self?.productDetailsViewModel.numberPages = 0
            self?.requestEvalueListData()
        }) {[weak self] in
            self?.productDetailsViewModel.numberPages += 15
            self?.requestEvalueListData()
        }
    }
    
    // 获取商品评价列表数据
    private func requestEvalueListData() {
        productDetailsViewModel.getEvalutionList(shoppingID: shoppingID) {[weak self] in

            var ok = 0
            self?.productDetailsViewModel.evaluetionListDatas.forEach({ (model) in
                if model.score == "5"{
                     ok = ok + 1
                }
            })
            let okk = Int(ok/(self?.productDetailsViewModel.evaluetionListDatas.count)!)*100
            self?.satisfactionLabel.text = "\(okk)"
            
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - lazy load
    fileprivate lazy var productDetailsViewModel: DDProductDetailsViewModel = {[weak self] in
        let viewModel = DDProductDetailsViewModel()
        viewModel.tableView = self?.tableView
        return viewModel
    }()
}

// MARK: - UITableViewDataSource
extension MMLViewCommentsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = tableView.mj_footer {
            tableView.mj_footer.isHidden = productDetailsViewModel.evaluetionListDatas.isEmpty
        }
        return productDetailsViewModel.evaluetionListDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: MMLProductCommentCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: MMLProductCommentCell.self)) as? MMLProductCommentCell
        if let _ = cell {
        }else {
            cell = Bundle.main.loadNibNamed(String.init(describing: MMLProductCommentCell.self), owner: nil, options: nil)?.first as? MMLProductCommentCell
        }
        cell?.indexPath = indexPath
        cell?.delegate = self
        let model = productDetailsViewModel.evaluetionListDatas[indexPath.row]
        cell?.evaluateData = model
        weak var tempModel: MMLProductDetailsEvaluateData? = model
        cell?.shopFabulousButtonClick = {[weak self](button)in
            if button.isSelected {
                self?.productDetailsViewModel.delShopFabulous(shoppingID: (self?.shoppingID)!, evaluateID: (model.evaluateID)! , successBlock: {[weak self] in
                    tempModel?.fabulous = "\(Int((tempModel?.fabulous)!)! - 1)"
                    button.isSelected = false
                    model.totalFabulous = 0;
                    self?.tableView.reloadRows(at: [indexPath], with: .none)
                })
            }else {
                self?.productDetailsViewModel.addShopFabulous(shoppingID: (self?.shoppingID)!, evaluateID: (model.evaluateID)!, successBlock: {[weak self] in
                    tempModel?.fabulous = "\(Int((tempModel?.fabulous)!)! + 1)"
                    button.isSelected = true
                    model.totalFabulous = 1;
                    self?.tableView.reloadRows(at: [indexPath], with: .none)
                })
            }
        }
        return cell!
    }
    
}

// MARK: - UITableViewDelegate
extension MMLViewCommentsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = productDetailsViewModel.evaluetionListDatas[indexPath.row]
        var images = (model.evaluateImg.components(separatedBy: ","))
        if  model.evaluateImg == "" {
            images.removeAll()
        }
        let column = 3
        let row = images.count % column == 0 ? images.count / column : (images.count / column) + 1
        let itemWH = (UIScreen.main.bounds.width - 30 - 10) / 3.0
        let collectionViewH =  CGFloat(Int(itemWH) * row + (5 * (row - 1)))
        return 96.0 + (collectionViewH > 0 ? collectionViewH : 0)
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - MMLProductCommentCellDelegate
extension MMLViewCommentsVC: MMLProductCommentCellDelegate {
    // 评论点赞
    func productCommentCellShopFabulous(button: UIButton, currentIndex: Int) {
//        self.productDetailsViewModel.numberPages = 0
//        self.requestEvalueListData()
    }
    
    func viewCommentImages(contentImags: [String], currentIndex: Int) {
        MMLPhotoViewer.shared.viewImages(vc: self, images: contentImags, currentIndex: currentIndex)
    }
}

