//
//  SongModel.swift
//  SpotifyDemo
//
//  Created by Ling Zhan on 2024/10/4.
//
import Foundation

struct SongModel: Codable, Hashable {
    var title: String?
    var artist: String?
    var duration: Double?
    var isFavorite: Bool?
    var releaseDate: Date?
    var songId: String?
    
    /// 組合圖片網址
    func getArtistUrl() -> URL? {
        let appURL = AppURL.shared
        let urlString = "\(appURL.coverFirestorage)\(artist ?? "")-\(title ?? "").jpg?\(appURL.mediaAlt)"
        return URL(string: urlString)
    }
    
    /// 組合歌曲網址
    func getSongUrl() -> URL? {
        let appURL = AppURL.shared
        let urlString = "\(appURL.songFirestorage)\(artist ?? "")-\(title ?? "").mp3?\(appURL.mediaAlt)"
        return URL(string: urlString)
    }
    
    // 取得歌曲時間
    func getDuration() -> String {
        guard let duration = duration else { return "" }
        // 轉成字串
        let time = String(duration)
        // 取代 "." to ":"
        let timeString = time.replacingOccurrences(of: ".", with: ":")
        return timeString
    }
}
