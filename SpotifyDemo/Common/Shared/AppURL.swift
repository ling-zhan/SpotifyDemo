//
//  AppURL.swift
//  SpotifyDemo
//
//  Created by Ling Zhan on 2024/10/1.
//

import Foundation

class AppURL {
    
    static let shared = AppURL()
    
    /// Firebase 圖片與檔案的命名及相對應的連結
    /// =========================
    /// 請修改底下連結，於 firebase storage 上面圖片與音樂檔案的連結網址
    ///
    /// 圖片格式：ChristinaPerri-AThousandYears.jpg
    /// https://firebasestorage.googleapis.com/v0/b/fir-storage-684d1.appspot.com/o/covers%2FChristinaPerri-AThousandYears.jpg?alt=media
    ///
    ///  音樂格式：ChristinaPerri-AThousandYears.mp3
    /// https://firebasestorage.googleapis.com/v0/b/fir-storage-684d1.appspot.com/o/songs%2FChristinaPerri-AThousandYears.mp3?alt=media
    ///
    ///  若要自行定義圖片與音樂檔案命名的格式，請再修改 SongModel.swift 的 getArtistUrl() 與 getSongUrl() 方法
    ///  注意，上傳至 firebase 的圖片，最好在名稱別有空格，不然很麻煩!
    
    // firebase 歌曲圖片路徑
    let coverFirestorage: String = "https://firebasestorage.googleapis.com/v0/b/fir-storage-684d1.appspot.com/o/covers%2F"
    
    // firebase 歌曲路徑
    let songFirestorage: String = "https://firebasestorage.googleapis.com/v0/b/fir-storage-684d1.appspot.com/o/songs%2F"
    
    let mediaAlt: String = "alt=media"
}
