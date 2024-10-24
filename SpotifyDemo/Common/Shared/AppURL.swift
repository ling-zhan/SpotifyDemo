//
//  AppURL.swift
//  SpotifyDemo
//
//  Created by Ling Zhan on 2024/10/1.
//

import Foundation

class AppURL {
    
    static let shared = AppURL()
    
    let coverFirestorage: String = "https://firebasestorage.googleapis.com/v0/b/fir-storage-684d1.appspot.com/o/covers%2F"
    let songFirestorage: String = "https://firebasestorage.googleapis.com/v0/b/fir-storage-684d1.appspot.com/o/songs%2F"
    let mediaAlt: String = "alt=media"
    let defaultImage: String = "https://cdn-icons-png.flaticon.com/512/10542/10542486.png"
    
    func getCoverURL(_ coverName: String) -> String {
        return "\(coverFirestorage)\(coverName)?\(mediaAlt)"
    }
    
    func getSongURL(_ songName: String) -> String {
        return "\(songFirestorage)\(songName)?\(mediaAlt)"
    }
}

/**
 * 注意，上傳至 firebase 的圖片，最好在名稱別有空格，不然很麻煩!
 *  圖片
 *  https://firebasestorage.googleapis.com/v0/b/fir-storage-684d1.appspot.com/o/covers%2FChristina%20Perri-A%20Thousand%20Years.jpg?alt=media
 *  音樂
 *  https://firebasestorage.googleapis.com/v0/b/fir-storage-684d1.appspot.com/o/songs%2FEdSheeran-Perfect.mp3?alt=media
 * */
