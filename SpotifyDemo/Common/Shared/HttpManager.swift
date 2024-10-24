//
//  HttpManager.swift
//  SpotifyDemo
//
//  Created by Ling Zhan on 2024/10/1.
//

import Foundation

class HttpManager {
    
    static let shared = HttpManager()
    
    // 加載網路圖片
    func loadImage(url: URL, completion: @escaping (Data?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data)
        }
        task.resume()
    }
    
    // 加載網路歌曲
    func loadSong(url: URL, completion: @escaping (Data?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data)
        }
        task.resume()
    }
}
