//
//  MMLMusicPlayer.swift
//  Meimeila
//
//  Created by macos on 2017/11/27.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import AVFoundation


@objc protocol MMLMusicPlayerDelegate{
    
    func downLoadFinish()
    
}

class MMLMusicPlayer{

    weak var delegate:MMLMusicPlayerDelegate?
    
    static var shared = MMLMusicPlayer.init()
    fileprivate init(){
        downService = JQDownLoadService.shared;
        downService?.delegate = self
        
    };
   
    lazy var SQ:MMLMusicSQManger = {
        let sq = MMLMusicSQManger.shared;
        sq.creatSQ();
        return sq;
    }()
    
    var musicDownLoadArr = [JQDownLoadVoiceModel]()
    var downService:JQDownLoadService?
    var musicDownLoadModel:JQDownLoadVoiceModel?
    
    
    ///播放器
    lazy var playerService:JQPlayerService = {
        let p = JQPlayerService.shared;
        return p;
    }()
    
    var playerStatue:Int = 10;
    
    ///stk播放器
    lazy var stkPlayer:STKAudioPlayerManger = {
        let p = STKAudioPlayerManger.shared;
        return p;
    }()
}


extension MMLMusicPlayer{
    
    ///下载音乐
    func downLoadMusic(music:JQDownLoadVoiceModel){
        
        JQDownLoadService.downLoadVoiceM(model: music);
    }
    
}

extension MMLMusicPlayer{

    
    ///删除音乐
    func deleteLocationMusic(model: JQDownLoadVoiceModel,deleteSucceed:()->()) {
        
      var isFileExist = downService?.isFileExist(model: model);
        
        JQDownLoadService.removeVoiceM(model: model);
        
        isFileExist = downService?.isFileExist(model: model);
        
        if !isFileExist! {
            print("删除成功!");
            
            SQ.SQ_delete(url: model.downloadUrl, succeeds: {
                
                BFunction.shared.showSuccessMessage("删除成功!");
                deleteSucceed()
                
            }, fales: {
                
                BFunction.shared.showErrorMessage("删除失败!");

            })
            
        }else{
            
            print("删除失败");
        }
        
        
        
    }
    
    
    ///查找音乐
    func SQ_musicAllList()-> Bool{
        
        musicDownLoadArr.removeAll();
        musicDownLoadArr = SQ.SQ_readALL();
        
        if musicDownLoadArr.count > 0 {
            return true;
        }
        
        return false;
    }
    
    
    ///查找某条音乐
    func SQ_music() -> Bool {
        
        let find = SQ.SQ_readOne(url: musicDownLoadModel?.downloadUrl ?? "");
        
        return find;
    }
    
    
}

extension MMLMusicPlayer:JQDownLoadServiceDelegate{
    func downLoadSucceedsfilePath(filePath: String?) {
        
        BFunction.shared.showMessage(filePath ?? "url-nil")
        
        
        if let _ = filePath {
        }

        if let _ = filePath {
            
            if SQ_music(){
                
            }else{
                
                if let _ = musicDownLoadModel{
                    
                    SQ.SQ_add(songdata: (musicDownLoadModel?.name)!, url: (musicDownLoadModel?.downloadUrl)!,filePath: filePath!, succeeds: {
                        
                        
                        delegate?.downLoadFinish();
                        
                    }, falses: {
                        
                    })
                    
                }else{
                
               
                }
            }
            
        }
        
    }

}


extension MMLMusicPlayer:JQAudioToolDelegate{
    
    func JQaudioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
    }
    
}
