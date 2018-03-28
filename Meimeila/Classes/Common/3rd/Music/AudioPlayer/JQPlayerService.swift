//
//  JQPlayerService.swift
//  AudioPlayerDemo
//
//  Created by HJQ on 2017/11/20.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class JQPlayerService {
    
    static let shared = JQPlayerService()
    private init() {}
    
    var currentPlayURL: NSURL!
    private var isRemoteURL: Bool = false
    
    // 播放链接
    func playWithURL(url: NSURL, stateBlock: @escaping (_ state: AudioState) -> ()) {
        self.currentPlayURL = url
        // 远程地址
        if (url.absoluteString?.uppercased().contains("HTTP"))! {
            isRemoteURL = true
            if self.localAudioTool.getIsPlaying() {
                self.localAudioTool.pauseCurrentAudio()
            }
            self.remoteAudioTool.playAudioWithPath(url: url, stateBlock: { (state) in
                stateBlock(self.getState())
            })
            
        }else {
            isRemoteURL = false
            // 注意: 暂停远程, 会造成回调延迟, 导致block调用先本地开始, 远程暂停
            if self.remoteAudioTool.state == AudioState.AudioLoading {
                self.remoteAudioTool.pauseCurrentAudio()
            }
            self.localAudioTool.playAudioWithPath(filePath: url, stateBlock: { (isPlaying) in
                stateBlock(self.getState())
            })
            
        }
    }
    
    // 播放
    func playCurrentAudio() {
        if isRemoteURL {
            self.remoteAudioTool.playCurrentAudio()
        }else {
            self.localAudioTool.playCurrentAudio()
        }
        
    }
    
    // 暂停
    func pauseCurrentAudio() {
        if isRemoteURL {
            self.remoteAudioTool.pauseCurrentAudio()
        }else {
            self.localAudioTool.pauseCurrentAudio()
        }
    }
    
    // 当前播放的时间
    func currentPlayTime() -> Double {
        return isRemoteURL ? Double(self.remoteAudioTool.currentPlayTime()) : self.localAudioTool.currentPlayTime()
    }
    
    // 音频的时间总长
    func currentTotalTime()  -> Double {
        return isRemoteURL ? Double(self.remoteAudioTool.currentTotalTime()) : self.localAudioTool.currentTotalTime()
    }
    
    // 快退
    func seekBack(time: Float) {
        if isRemoteURL {
            self.remoteAudioTool.seekBack(time: time)
        }else {
            self.localAudioTool.seekBack(time: Double(time))
        }
    }
    
    // 快进
    func seekFast(time: Float) {
        if isRemoteURL {
            self.remoteAudioTool.seekFast(time: time)
        }else {
            self.localAudioTool.seekFast(time: Double(time))
        }
    }
    
    
    func seekProgress(progress: Double) {
        if isRemoteURL {
            self.remoteAudioTool.seekProgress(progress: Float(progress))
        }else {
            self.localAudioTool.seekProgress(progress: progress)
        }
    }
    
    // 播放速率
    func changeRate(rate: Float) {
        if isRemoteURL {
            self.remoteAudioTool.changeRate(rate: rate)
        }else {
            self.localAudioTool.changeRate(rate: rate)
        }
    }
    
    // 获取当前的播放状态
    func getState() -> AudioState {
        if isRemoteURL {
           return self.remoteAudioTool.state
        }else {
            let isPlaying = self.localAudioTool.getIsPlaying()
            if isPlaying {
                return .AudioPlaying
            }else {
                return .AudioPause
            }
        }
        
    }
    
    // MARK: - Lazy load
    private lazy var localAudioTool: JQAudioTool = JQAudioTool()
    
    private lazy var remoteAudioTool: JQRemoteAudioTool = JQRemoteAudioTool()

}
