//
//  PlayViewModel.swift
//  SpotifyDemo
//
//  Created by Ling Zhan on 2024/10/4.
//
//  AVAudioPlayer 文獻:
// https://chao-shin-mail.medium.com/ios13-app-swift5-%E5%AF%A6%E4%BE%8B%E8%AA%AA%E6%98%8E-%E7%AE%97%E6%95%B8%E7%B7%B4%E7%BF%92app-%E5%BD%B1%E9%9F%B3%E7%AF%87-acd61fdcea73

import Foundation
import AVFoundation

protocol PlayViewModelDelegate: AnyObject {
    /// 抓取歌曲完成
    func fetchSongComplete(error: String?)
    
    /// 更新 Cell
    func didUpdateTableCells(_ section: Int, with indexPaths: [Int])
}

class PlayViewModel: NSObject {
    
    // 歌曲
    var song: SongModel?
    
    // 音樂播放器
    var audioPlayer: AVAudioPlayer?
    
    // 計時器
    var timer: Timer?
    
    // 是否正在播放
    var isPlaying: Bool = false
    
    // 當前播放時間
    var currentTime: TimeInterval = 0
    
    // 歌曲總時間
    var duration: TimeInterval = 0
    
    // 是否可以播放(因為歌曲需要加載)
    var isCanPlay: Bool = false
    
    weak var delegate: PlayViewModelDelegate?
    
    init(song: SongModel) {
        self.song = song
    }
}

// MARK: - API
extension PlayViewModel {
    /// 抓取歌曲
    func fetchSong() {
        guard let url = song?.getSongUrl() else { return }
        
        HttpManager.shared.loadSong(url: url) { data in
            guard let data = data else { return }

            do {
                self.audioPlayer = try AVAudioPlayer(data: data)
                self.audioPlayer?.prepareToPlay()
                self.audioPlayer?.delegate = self
                
                self.duration = self.audioPlayer?.duration ?? 0
                self.isCanPlay = true
                self.delegate?.fetchSongComplete(error: nil)
            } catch {
                self.delegate?.fetchSongComplete(error: error.localizedDescription)
            }
        }
    }
}

//MARK: AVAudioPlayer 操作
extension PlayViewModel {
    
    /// 播放
    func startPlay() {
        self.audioPlayer?.play()
        self.isPlaying = true
        self.startTimer()
        self.updatePlayProgress()
    }
    
    // 停止播放
    func stopPlay() {
        self.audioPlayer?.stop()
        self.isPlaying = false
        self.currentTime = 0
        self.updatePlayProgress()
    }
    
    /// 暫停(不用再更新 Progress)
    func pausePlay() {
        self.audioPlayer?.pause()
        self.isPlaying = false
        self.stopTimer()
    }
    
    /// 跳到指定時間(不用再更新 Progress)
    func seekToTime(time: TimeInterval) {
        // 設定音樂時間，這個要在音樂播放之前設定(正在播時，此設定不會理你)
        self.audioPlayer?.currentTime = time
        self.currentTime = time
        self.isPlaying = true
        self.startTimer()
        self.audioPlayer?.play()
    }
    
    /// 更新播放進度
    func updatePlayProgress() {
        self.delegate?.didUpdateTableCells(0, with: [4])
    }
}

// MARK: - Timer
extension PlayViewModel {
    /// 開始計時
    func startTimer() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            // currentTime 小數點 無條件進位，才能與倒數即時的時間相符，不然音樂會快一些(秒數)
            let currentTime = round(self.audioPlayer?.currentTime ?? 0)
            print("startTimer... \(currentTime)")
            
            self.currentTime = currentTime
            self.updatePlayProgress()
        }
    }
    
    /// 停止計時
    func stopTimer() {
        self.timer?.invalidate()
    }
}

// MARK: - AVAudioPlayerDelegate
extension PlayViewModel: AVAudioPlayerDelegate {
    // 播放完畢
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("audioPlayerDidFinishPlaying")
        self.timer?.invalidate()
        self.isPlaying = false
        self.currentTime = 0
        self.updatePlayProgress()
    }
}
 
