//
//  JQAudioTool.swift
//  AudioPlayerDemo
//
//  Created by HJQ on 2017/11/20.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit
import AVFoundation
@objc protocol JQAudioToolDelegate{
    
    func JQaudioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool)
    
    
}

class JQAudioTool: NSObject {

    // 是否正在播发
    func getIsPlaying() -> Bool {
        guard let _ = self.player else {
            return false
        }
        return self.player.isPlaying
    }
    
    // 音乐播发器
    private var player: AVAudioPlayer!
    weak var delegate:JQAudioToolDelegate?
    
    typealias StateBlock = (_ isPlaying: Bool) -> ()
    private var stateBlock: StateBlock!
    
    func playAudioWithPath(filePath: NSURL, stateBlock:@escaping (_ isPlaying: Bool)->()) {
        self.stateBlock = stateBlock
        if self.player != nil {
            if filePath.isEqual(self.player.url) {
                self.player.play()
                stateBlock(self.player.isPlaying)
            }
        }

        do {
            try self.player = AVAudioPlayer.init(contentsOf: filePath as URL)
            self.player.enableRate = true
            self.player.delegate = self;
            self.player.prepareToPlay()
            self.player.play()
            stateBlock(self.player.isPlaying)
        }
        catch {
            print(error)
        }
        
        
    }
    
    // 播放
    func playCurrentAudio() {
        self.player.play()
        stateBlock(self.player.isPlaying)
    }
    
    // 暂停
    func pauseCurrentAudio(){
        self.player.pause()
        stateBlock(self.player.isPlaying)
    }
    
    // 当前播放的时间
    func currentPlayTime() -> Double {
        return self.player.currentTime
        
    }
    
    // 总时长
    func currentTotalTime() -> Double {
        return self.player.duration
        
    }
    
    // 快进和快退
    func seekBack(time: Double) {
        self.player.currentTime -= time
    }
    func seekFast(time: Double) {
        self.player.currentTime += time
    }
    func seekProgress(progress: Double) {
        self.player.currentTime = self.player.duration * progress
    }
    
    func changeRate(rate: Float) {
        self.player.rate = rate
    }
    
    // MARK: - Private method
    private func setBackPlay() {
        // 1.获取音频会话
        let session = AVAudioSession.sharedInstance()
        // 2.设置音频会话类型
        do {
            try session.setActive(true)
            try session.setCategory(AVAudioSessionCategoryPlayback)
        } catch {
            print(error)
        }
    
    }
    
    
}

extension JQAudioTool:AVAudioPlayerDelegate{
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
        delegate?.JQaudioPlayerDidFinishPlaying(player, successfully: flag);
    }
    
}
