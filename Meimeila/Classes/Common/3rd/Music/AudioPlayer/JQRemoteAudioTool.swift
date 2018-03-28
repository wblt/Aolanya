//
//  JQRemoteAudioTool.swift
//  AudioPlayerDemo
//
//  Created by HJQ on 2017/11/20.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import FreeStreamer

enum AudioState: Int {
    case AudioPlaying
    case AudioPause
    case AudioLoading
}

class JQRemoteAudioTool: NSObject {


    var state: AudioState!
    
    // 是否正在播发
    func getIsPlaying() -> Bool {
        guard let _ = self.audioStream else {
            return false
        }
        return self.audioStream.isPlaying()
    }
    
    // 音乐播发器
    private var audioStream: FSAudioStream!
    
    typealias StateBlock = (_ state: AudioState) -> ()
    private var stateBlock: StateBlock!
    
    func playAudioWithPath(url: NSURL, stateBlock:@escaping (_ state: AudioState)->()) {
        self.stateBlock = stateBlock
        if self.audioStream != nil {
            if url.isEqual(self.audioStream.url) {
                if !self.audioStream.isPlaying() {
                    self.audioStream.pause()
                }
            }
            return
        }
        
        let config = FSStreamConfiguration.init()
        config.enableTimeAndPitchConversion = true
        config.cacheEnabled = true
        config.cacheDirectory = NSTemporaryDirectory()
        config.seekingFromCacheEnabled = true
        
        self.audioStream = FSAudioStream.init(configuration: config)
        self.audioStream.url = url
        self.audioStream.onStateChange = {[weak self](state: FSAudioStreamState) in
            
            if state ==  FSAudioStreamState.fsAudioStreamPlaying{
                self?.state = .AudioPlaying
                stateBlock(.AudioPlaying)
            }else if state == FSAudioStreamState.fsAudioStreamPaused || state == FSAudioStreamState.fsAudioStreamRetryingFailed || state == FSAudioStreamState.fsAudioStreamFailed {
                self?.state = .AudioPause
                stateBlock(.AudioPause)
            }else {
                self?.state = .AudioLoading
                stateBlock(.AudioLoading)
            }
        }
        
        self.audioStream.preload()
        self.audioStream.play()
        
    }
    
    // 播放
    func playCurrentAudio() {
        if !self.audioStream.isPlaying() {
            self.audioStream.play()
        }
    }
    
    // 暂停
    func pauseCurrentAudio(){
        if self.audioStream.isPlaying() {
            self.audioStream.pause()
        }
    }
    
    
    // 当前播放的时间
    func currentPlayTime() -> Float {
        return self.audioStream.currentTimePlayed.playbackTimeInSeconds
        
    }
    
    // 总时长
    func currentTotalTime() -> Float {
        return self.audioStream.duration.playbackTimeInSeconds
        
    }
    
    // 快进和快退
    func seekBack(time: Float) {
        var position = FSStreamPosition.init()
        position.position = (self.currentPlayTime() - time) / self.currentTotalTime()
        if position.position < 0 {
            position.position = 0.0000000001
        }
        self.audioStream.volume = 0
        self.audioStream.seek(to: position)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.3) {
           self.audioStream.volume = 1
        }
    }
    
    func seekFast(time: Float) {
        var position = FSStreamPosition.init()
        position.position = (self.currentPlayTime() + time) / self.currentTotalTime()
        if position.position > 1 {
            position.position = 1
        }
        self.audioStream.volume = 0
        self.audioStream.seek(to: position)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.3) {
            self.audioStream.volume = 1
        }
    }
    func seekProgress(progress: Float) {
        var position = FSStreamPosition.init()
        position.position = progress
        if position.position > 1 {
            position.position = 1
        }
        self.audioStream.volume = 0
        self.audioStream.seek(to: position)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.3) {
            self.audioStream.volume = 1
        }
    }
    
    func changeRate(rate: Float) {
        self.audioStream.setPlayRate(rate)
    }
    
}
