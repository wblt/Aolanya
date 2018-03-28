//
//  MMLRedenvelopeVC.swift
//  Meimeila
//
//  Created by HJQ on 2017/10/19.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import AVFoundation

class MMLRedenvelopeVC: DDBaseViewController {

    private var audioPlay: AVAudioPlayer!
    
    init() {
        super.init(nibName: String.init(describing: MMLRedenvelopeVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "签到红包"
    }
    
    override func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Private methods
    private func requestSignRedData(type: Int) {
        redenvelopeViewModel.redenvelopeRecive(type: type, successBlock: {[weak self](meney) in
            self?.playMusic()
            let VC = MMLRedenvelopePopupVC()
            VC.money = meney
            VC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            self?.present(VC, animated: false, completion: nil)
        })
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

    
    // MARK: - Lazy load
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView.tableFooterView = UIView.init()
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: String.init(describing: MMLRedenvelopeCell.self), bundle: nil), forCellReuseIdentifier: String.init(describing: MMLRedenvelopeCell.self))
        return tableView
    }()
    
    private var datas: [[String: String]] = {
        var array = [[String: String]]()
        array.append(["title":"早安签到", "time":"每日00:00:00-07:59:59"])
        array.append(["title":"午间签到", "time":"每日08:00:00-15:59:59"])
        array.append(["title":"晚餐签到", "time":"每日16:00:00-23:59:59"])
        return array
    }()
    
    private lazy var redenvelopeViewModel: MMLRedenvelopeViewModel = {
        let vm = MMLRedenvelopeViewModel()
        return vm
    }()


}

// MARK: - UITableViewDataSource
extension MMLRedenvelopeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: MMLRedenvelopeCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: MMLRedenvelopeCell.self)) as? MMLRedenvelopeCell
        if let _ = cell {
        }else {
            cell = Bundle.main.loadNibNamed(String.init(describing: MMLRedenvelopeCell.self), owner: nil, options: nil)?.first as? MMLRedenvelopeCell
        }
        cell?.selectionStyle = .none
        cell?.indexPath = indexPath
        cell?.delegate = self
        cell?.dict = datas[indexPath.row]
        return cell!
    }
    
}

// MARK: - UITableViewDelegate
extension MMLRedenvelopeVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - MMLRedenvelopeCellDelegate
extension MMLRedenvelopeVC: MMLRedenvelopeCellDelegate {
    func redenvelopeCellReceive(index: Int) {
        if checkInLogin() {return}
        debugLog("红包领取")
        requestSignRedData(type: index)
    }
    
    
}
