//
//  MMLMusicVC.swift
//  Meimeila
//
//  Created by macos on 2017/11/27.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class MMLMusicVC: DDBaseViewController {

    @IBOutlet weak var tableView: UITableView!
  
    
    @IBOutlet weak var loveTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindMJ();
        httpRquest();
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if player.SQ_musicAllList(){
            
            tableView.reloadData();
        }
        
        
    }
    
    // 如果不写这个方法，iOS8会崩溃
    init() {
        super.init(nibName: String.init(describing: MMLMusicVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupUI() {
        
        navigationItem.titleView = searchTextField;
        setTableView();
        setLoveTableView();
        
        addNavBarRightButton(btnTitle: "搜索", titleColor: UIColor.white) { [weak self](btn) in
            self?.searchTextField.resignFirstResponder();
            print("搜索");
            
            let vc = MMLMusicSearchVC();
            vc.player = self?.player;
            self?.navigationController?.pushViewController(vc, animated: true);
            
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
        vm.tableView = self?.loveTableView;
        return vm;
        }()
    
    
    ///播放器
    var player:MMLMusicPlayer!
    
}


extension MMLMusicVC{
    
    ///猜你喜欢的
    func httpRquest() {
        vm.musicListRequest(num:Int(arc4random()%6 + 1)) {[weak self] in
            
            self?.loveTableView.reloadData();
        }
    }
    
    
    func bindMJ() {
        
        setupRefresh(loveTableView, isNeedFooterRefresh: true, headerCallback: {[weak self] in
            self?.httpRquest()
            self?.vm.numberPage = 0;
        }) {[weak self] in
            self?.httpRquest();
            self?.vm.numberPage += 15;
        }
        
    }
    
    func setTableView() {
        
        let titleLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: Screen.width, height: 44));
        titleLabel.text = "  已下载歌曲"
        titleLabel.textColor = UIColor.black;
        tableView.tableHeaderView = titleLabel;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 105;
        tableView.tableFooterView = UIView.init();
        tableView.backgroundColor = DDGlobalBGColor()
        tableView.showsVerticalScrollIndicator = false;

        tableView.register(UINib.init(nibName: String.init(describing: MMLMusicCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: MMLMusicCell.self));
        
    }
    
    
    func setLoveTableView() {
        
        let titleLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: Screen.width, height: 44));
        titleLabel.text = "  猜你喜欢的歌曲"
        titleLabel.textColor = UIColor.black;
        loveTableView.tableHeaderView = titleLabel;
        loveTableView.delegate = self;
        loveTableView.dataSource = self;
        loveTableView.rowHeight = 105;
        loveTableView.tableFooterView = UIView.init();
        loveTableView.backgroundColor = DDGlobalBGColor()
        loveTableView.showsVerticalScrollIndicator = false;
        
        loveTableView.register(UINib.init(nibName: String.init(describing: MMLMusicDownLoadCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: MMLMusicDownLoadCell.self));
        
    }
    
}

extension MMLMusicVC:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == self.tableView {
            var cell:MMLMusicCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: MMLMusicCell.self)) as? MMLMusicCell;
            cell?.separatorInset.left = 0;
            cell?.selectionStyle = .none;
            if let _ = cell {
                
            }else{
                
                cell = Bundle.main.loadNibNamed(String.init(describing: MMLMusicCell.self), owner: nil, options: nil)?.last as? MMLMusicCell;
            }
            let dModel = player.musicDownLoadArr[indexPath.row];
            let model = MMLMusicModel.init(DModel: dModel);
            cell?.musicListModel = model;
            
            cell?.playBt.addTarget(self, action: #selector(playMusic(bt:)), for: UIControlEvents.touchUpInside);
            cell?.rubbishBt.addTarget(self, action: #selector(rubbishMusic(bt:)), for: UIControlEvents.touchUpInside);
            cell?.playBt.tag = indexPath.row + 3333;
            cell?.rubbishBt.tag = indexPath.row + 3333;
            
            return cell!;
        }else{
            
            var cell:MMLMusicDownLoadCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: MMLMusicDownLoadCell.self)) as? MMLMusicDownLoadCell;
            cell?.separatorInset.left = 0;
            cell?.selectionStyle = .none;
            if let _ = cell {
                
            }else{
                
                cell = Bundle.main.loadNibNamed(String.init(describing: MMLMusicDownLoadCell.self), owner: nil, options: nil)?.last as? MMLMusicDownLoadCell;
            }
        
            cell?.playBt.addTarget(self, action: #selector(playRemoteMusic(bt:)), for: .touchUpInside);
            cell?.downBt.addTarget(self, action: #selector(downLoadRemoteMusic(bt:)), for: .touchUpInside);
            cell?.playBt.tag = indexPath.row + 3333;
            cell?.downBt.tag = indexPath.row + 3333;
            cell?.musicListenModel = vm.musicListArr[indexPath.row];
            return cell!;
            
        }
        
       
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.tableView {
            
            tableView.displayprompts(message: "暂无数据", image: "icon_orderEmpty", cellCount: player.musicDownLoadArr.count);
            
            if let _ = tableView.mj_footer {
                
                tableView.mj_footer.isHidden = player.musicDownLoadArr.count > 0 ? false : true
            }
            return player.musicDownLoadArr.count;
       
        }else{
            
            tableView.displayprompts(message: "暂无数据", image: "icon_orderEmpty", cellCount: vm.musicListArr.count);
            
            if let _ = tableView.mj_footer {
                
                tableView.mj_footer.isHidden = vm.musicListArr.count > 0 ? false : true
            }
            return vm.musicListArr.count;
            
        }
    }
    
}


extension MMLMusicVC:UITableViewDelegate{
    
}


extension MMLMusicVC:UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let vc = MMLMusicSearchVC();
        vc.player = player;
        navigationController?.pushViewController(vc, animated: true);
        return false;
    }
}

///播放-删除本地音乐
extension MMLMusicVC {
    
    @objc func playMusic(bt:UIButton){
        let music = player.musicDownLoadArr[bt.tag - 3333];
        
        let musicPath = music.downloadUrl;
        print("播放本地音乐\(musicPath)")

        player.stkPlayer.play(url: musicPath);
    }
    
    
    @objc func rubbishMusic(bt:UIButton){
        print("删除本地音乐");
        let mode = player.musicDownLoadArr[bt.tag - 3333];
        
        player.deleteLocationMusic(model: mode) {
            
            player.SQ_musicAllList();
            tableView.reloadData();
        }
        
        
    }
}


///播放下载远程音乐
extension MMLMusicVC :MMLMusicPlayerDelegate{
    func downLoadFinish() {
        
        if player.SQ_musicAllList(){
            
            tableView.reloadData();
        }
    }
    
    
    @objc func playRemoteMusic(bt:UIButton){
        print("试听你喜欢的")
        
        let row = bt.tag - 3333;
        let music = vm.musicListArr[row];
        
        player.stkPlayer.play(url: music.url!);
    }
    
    
    @objc func downLoadRemoteMusic(bt:UIButton){
        
        print("下载你喜欢听的")
    
        let row = bt.tag - 3333;
        let music = vm.musicListArr[row];
        
        let Dmodel = JQDownLoadVoiceModel.init();
        Dmodel.downloadUrl = music.url ?? "";
        Dmodel.name = music.songdata ?? music.name!;
        player.musicDownLoadModel = Dmodel;
        player.downLoadMusic(music: Dmodel);
        
    }
}
