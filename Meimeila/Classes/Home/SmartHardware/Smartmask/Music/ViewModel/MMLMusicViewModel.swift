//
//  MMLMusicViewModel.swift
//  Meimeila
//
//  Created by macos on 2017/11/27.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import SwiftyJSON
class MMLMusicViewModel {

    var numberPage:Int = 0;
    var pagesize:Int = 10;
    var tableView:UITableView?
    
    ///本地音乐Arr
    var musicListArr = [MMLMusicModel]();
    ///搜索音乐Arr
    var musicListenArr = [MMLMusicModel]();
    var isMusicSearch:Bool = false;
    
    var musickeyword:String?
}

extension MMLMusicViewModel{
    
    
    ///加载远程数据
    func getRemoteData(haveUrl:@escaping (_ url:String)->(),haveAlready:(_ url:NSURL)->())  {
        
        if self.musicListArr.count > 0 {
            
            let model = self.musicListArr[0];
            let url = model.url;
            
            haveAlready(NSURL.init(string: url!)!);
        }else{
        
            self.musicListRequest(num: 5) {[weak self] in
                
                let haveMusic =  self?.musicListArr.count > 0 ? true:false
               
                if  haveMusic {
                    let model = self?.musicListArr[0];
                    let url = model?.url;
                    haveUrl(url!);
                }
            }
        }
    }
    
    
    
    ///猜你喜欢的
    func musicListRequest(num:Int,succeeds:@escaping ()->()) {
        
        let r = MusicAPI.musicList(num: num)
        DDHTTPRequest.request(r: r, requestSuccess: {[weak self] (responds) in
            
            let json = JSON.init(responds);
            print(json)
            
            if self?.numberPage == 0 {
                
                self?.musicListArr.removeAll();
            }
            
            let data = json["data"].arrayValue;
            
            data.forEach({ (item) in
                
                print(item);
                
                let model = MMLMusicModel.init(musicList: item);
                self?.musicListArr.append(model);
            })
        
            if let _ = self?.tableView{
            
                let isNomore = self?.musicListArr.count > 0 ? false:true;
                self?.endRefresh(isNomore: isNomore)
            }
            succeeds();
            
        }, requestError: {[weak self] (responds, errorModel) in
            BFunction.shared.showErrorMessage(errorModel.message)
            
            if let _ = self?.tableView{
                self?.endRefresh();
            }
            
        }) {[weak self] (error) in
            BFunction.shared.showErrorMessage(error.localizedDescription)
            
            
            if let _ = self?.tableView{
                self?.endRefresh();
            }
            
        }
    }
    
    
   ///搜索音乐
    func musicListenRequest(keyword:String,page:Int,pagesize:Int,succeeds:@escaping ()->()) {
        
        let r = MusicAPI.musicListen(keyword: keyword, page: page, pagesize: pagesize)
        DDHTTPRequest.request(r: r, requestSuccess: {[weak self] (responds) in
            
            let json = JSON.init(responds);
            print(json)
            
            if self?.numberPage == 0 {
                
                self?.musicListenArr.removeAll();
            }
            
            let data = json["data"].dictionaryValue;
            
            let count = data.count;
        
            for index in 1 ... count {
                
                let music = data["\(index)"];
                
                let model = MMLMusicModel.init(musicListen: music!);
                self?.musicListenArr.append(model);
                
            }
        
            let isNomore = self?.musicListArr.count > 0 ? false:true;
            self?.endRefresh(isNomore: isNomore)
            succeeds();
            }, requestError: {[weak self] (responds, errorModel) in
                BFunction.shared.showErrorMessage(errorModel.message)
                self?.endRefresh();
        }) {[weak self] (error) in
            BFunction.shared.showErrorMessage(error.localizedDescription)
            self?.endRefresh();
        }
    }
    
    
    // tableView停止刷新
    private func endRefresh(isNomore: Bool = false) {
        if numberPage == 0 {
            tableView?.mj_header.endRefreshing()
        }else {
            tableView?.mj_footer.endRefreshing()
            if isNomore {
                tableView?.mj_footer.endRefreshingWithNoMoreData()
            }
        }
    }
}
