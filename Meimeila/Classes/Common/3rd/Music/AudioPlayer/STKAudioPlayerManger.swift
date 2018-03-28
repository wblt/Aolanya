//
//  STKAudioPlayerManger.swift
//  Meimeila
//
//  Created by macos on 2018/1/13.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import UIKit
import StreamingKit

class STKAudioPlayerManger: NSObject {

    static var shared = STKAudioPlayerManger.init();
    fileprivate override init() {}
    
    lazy var STKPlayer:STKAudioPlayer = {
        let p = STKAudioPlayer.init()
        p.delegate = self;
        return p;
    }()
    
    var remoteUrl:String?
}

extension STKAudioPlayerManger{
    
    func play(url:String) {
        STKPlayer.play(url)
    }
    
    
    ///清空播放队列
    func stopPlaye() {
        STKPlayer.stop();
    }
    
    ///继续-重新开始
    func resumePlaye() {
        STKPlayer.resume();
    }
    
    ///暂停
    func pausePlay() {
        STKPlayer.pause();
    }
}

extension STKAudioPlayerManger:STKAudioPlayerDelegate{
    ///当一个项目开始播放调用
    func audioPlayer(_ audioPlayer: STKAudioPlayer, didStartPlayingQueueItemId queueItemId: NSObject) {
        
    }
    
    // 一般是歌曲快结束提前5秒调用
    func audioPlayer(_ audioPlayer: STKAudioPlayer, didFinishBufferingSourceWithQueueItemId queueItemId: NSObject) {
        
    }
    
    /// 当播放器 状态发生改变的时候调用，  暂停-开始播放都会调用
    func audioPlayer(_ audioPlayer: STKAudioPlayer, stateChanged state: STKAudioPlayerState, previousState: STKAudioPlayerState) {
        
    }
    
    ///当一个项目完成后，就调用
    func audioPlayer(_ audioPlayer: STKAudioPlayer, didFinishPlayingQueueItemId queueItemId: NSObject, with stopReason: STKAudioPlayerStopReason, andProgress progress: Double, andDuration duration: Double) {
        
    }
    
    /// 引发的意外和可能发生的不可恢复的错误，极少概率会调用。  就是此歌曲不能加载，或者url是不可用的
    func audioPlayer(_ audioPlayer: STKAudioPlayer, unexpectedError errorCode: STKAudioPlayerErrorCode) {
        
    }
    
    
}
