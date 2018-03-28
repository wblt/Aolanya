//
//  MMLMusicSearchVC.swift
//  Meimeila
//
//  Created by macos on 2017/11/27.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLMusicSearchVC: DDBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindMJ();
        
    }
    
    // 如果不写这个方法，iOS8会崩溃
    init() {
        super.init(nibName: String.init(describing: MMLMusicSearchVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupUI() {
        
        navigationItem.titleView = searchTextField;
        setTableView();
        
        addNavBarRightButton(btnTitle: "搜索", titleColor: UIColor.white) { [weak self](btn) in
            self?.searchTextField.resignFirstResponder();
            print("搜索");
            
            if let _ = self?.vm.musickeyword{
                
                self?.searchMusic();
            }else{
                BFunction.shared.showErrorMessage("请输入关键词")
                
            }
            
        }
    }
    
    // TODO: 宽度需要按比例
    private lazy var searchTextField: UITextField = {
        let width = Screen.width * 250 / 375
        let leftImageView = UIImageView.init(image: UIImage.init(named: "mall_search"))
        leftImageView.contentMode = .center
        leftImageView.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        let textField = DDMallSearchTextField.init(leftView: leftImageView, frame: CGRect.init(x: 0, y: 0, width: width, height: 30), color: nil, boardWidth: 0, boardRadius: 15)
        textField.backgroundColor = DDGlobalBGColor()
        textField.placeholder = "搜索歌曲"
        textField.returnKeyType = .search
        textField.delegate = self
        return textField
    }()
    
    lazy var vm:MMLMusicViewModel = {[weak self] in
        
        let vm = MMLMusicViewModel();
        vm.tableView = self?.tableView;
        return vm;
        }()
    
    
    var player:MMLMusicPlayer!
    
}

extension MMLMusicSearchVC{
    
    func httpRquest() {
        
        let url = vm.musickeyword ?? ""
        let page = vm.numberPage;
        let size = vm.pagesize;
        
        vm.musicListenRequest(keyword: url, page: page, pagesize: size) {
            
        }
    }
    
    func bindMJ() {
        
        setupRefresh(tableView, isNeedFooterRefresh: true, headerCallback: {[weak self] in
            self?.httpRquest()
            self?.vm.numberPage = 0;
        }) {[weak self] in
            self?.httpRquest();
            self?.vm.numberPage += 15;
        }
    }
    
    func setTableView() {
        
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 105;
        tableView.tableFooterView = UIView.init();
        tableView.backgroundColor = DDGlobalBGColor()
        tableView.showsVerticalScrollIndicator = false;
        
        tableView.register(UINib.init(nibName: String.init(describing: MineCollectCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: MineCollectCell.self));
        
    }
    
    ///搜索音乐
    func searchMusic() {
        
        let keyWord = vm.musickeyword ?? "";
        
        vm.musicListenRequest(keyword: keyWord, page: 0, pagesize: 10) {[weak self] in
            
            self?.tableView.reloadData();
        }
    }
    
    
    @objc func downLoadMusic(bt:UIButton){
        
        print("下载音乐");
        let row = bt.tag - 2222;
        let music = vm.musicListenArr[row];
        
        var Dmodel = JQDownLoadVoiceModel.init();
        Dmodel.downloadUrl = music.url ?? "";
        Dmodel.name = music.songdata ?? "";
        player.musicDownLoadModel = Dmodel;
        player.downLoadMusic(music: Dmodel);
    }
}

extension MMLMusicSearchVC:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:MMLMusicDownLoadCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: MMLMusicDownLoadCell.self)) as? MMLMusicDownLoadCell;
        cell?.separatorInset.left = 0;
        cell?.selectionStyle = .none;
        if let _ = cell {
            
        }else{
            
            cell = Bundle.main.loadNibNamed(String.init(describing: MMLMusicDownLoadCell.self), owner: nil, options: nil)?.last as? MMLMusicDownLoadCell;
        }
        
        cell?.musicListenModel = vm.musicListenArr[indexPath.row];
        cell?.downBt.tag = indexPath.row + 2222;
        cell?.downBt.addTarget(self, action: #selector(downLoadMusic(bt:)), for: UIControlEvents.touchUpInside);
        cell?.playBt.isHidden = true;
        return cell!;
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        tableView.displayprompts(message: "暂无数据", image: "icon_orderEmpty", cellCount: vm.musicListenArr.count);
        
        if let _ = tableView.mj_footer {
            
            tableView.mj_footer.isHidden = vm.musicListenArr.isEmpty;
        }
        
        return vm.musicListenArr.count;
    }
    
}

extension MMLMusicSearchVC:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension MMLMusicSearchVC:UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        vm.musickeyword = textField.text;
    }
    
    
}

