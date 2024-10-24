//
//  HomeViewModel.swift
//  SpotifyDemo
//
//  Created by Ling Zhan on 2024/9/26.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


protocol HomeViewModelDelegate: AnyObject {
    func addOrRemoveFavoriteSongSuccess(_ message: String)
    func addOrRemoveFavoriteSongFailure(_ error: String)
    func didUpdateTableCells(_ section: Int,with row: [Int])
}

class HomeViewModel {
    
    // TabBar 列表
    var tabBarCellViewModels: [TabBarCollectionCellViewModel] = [
        TabBarCollectionCellViewModel(title: "News", isSelected: true),
        TabBarCollectionCellViewModel(title: "Video", isSelected: false),
        TabBarCollectionCellViewModel(title: "Artist", isSelected: false),
        TabBarCollectionCellViewModel(title: "Podcast", isSelected: false)
    ]
    
    // TabBar 選項
    var taBarScrollToRow: Int = 0
    
    // TabBar 的 TableCell
    let tableCells: [[Int]] = [[1,2,3,4,5,6],[1]]
    
    // 新歌列表
    var newSongs: [SongModel] = []
    
    // 歌曲列表
    var playlistSongs: [SongModel] = []
    
    weak var delegate: HomeViewModelDelegate?
    
    
    
}

extension HomeViewModel {
    
    func didSelectItemAt(_ row: Int) {
        
        self.taBarScrollToRow = row
        
        // 更好的做法
        self.tabBarCellViewModels.enumerated().forEach { (index, viewModel) in
            self.tabBarCellViewModels[index].isSelected = index == row
        }

        /// 清掉舊的歌曲
        self.newSongs.removeAll()
        /// 重新抓取新的歌曲
        self.fetchNewsSongs()
        
        let section: Int = 0
        let cellRows: [Int] = [2,4]
        delegate?.didUpdateTableCells(section, with: cellRows)
    }
    
    func updateNewSongsUI() {
        let section: Int = 0
        let cellRows: [Int] = [4]
        delegate?.didUpdateTableCells(section, with: cellRows)
    }
    
    func updatePlaylistSongsUI() {
        let section: Int = 1
        let cellRows: [Int] = [0]
        delegate?.didUpdateTableCells(section, with: cellRows)
    }
}

// MARK: - API
extension HomeViewModel {
    
    /**
     * 若當 一個 closure 裡面有多個非同步任務，且這些任務之間沒有相依性，可以使用 DispatchGroup
     *  1. 建立一個 DispatchGroup
     *  2. 進入 DispatchGroup：dispatchGroup.enter()
     *  3. 離開 DispatchGroup： dispatchGroup.leave()
     *  4. 當所有任務完成，通知 DispatchGroup執行後續操作： dispatchGroup.notify(queue: .main) {...}
     *
     *  在這裡是 抓回來的歌曲，要再去打api，查詢是否是最愛歌曲，等到所有歌曲都查詢完後，再去更新 UI，因此在這裡使用 DispatchGroup 來確保所有歌曲查詢完成後再進行後續操作。
     */
    
    /// Fetch news songs from Firestore
    func fetchNewsSongs() {
        // 亂數 1~3(額外做的，讓它有切換 tab 的感覺)
        let random = Int.random(in: 1...3)
        
        // Fetch songs from Firestore order by releaseDate
        let query = Firestore.firestore().collection("Songs").order(by: "releaseDate", descending: true).limit(to: random)
        query.getDocuments { snapshot, error in
            
            guard error == nil else {
                print("Error: \(error!.localizedDescription)")
                return
            }
        
            self.newSongs.removeAll()
            
            // 使用 DispatchGroup 確保所有 isFavoriteSong 查詢完成後再進行後續操作
            let dispatchGroup = DispatchGroup()
            
            snapshot?.documents.forEach({ document in
                
                dispatchGroup.enter() // 進入 DispatchGroup
                
                let title = document["title"] as? String
                let artist = document["artist"] as? String
                let duration = document["duration"] as? Double
                let releaseDate = document["releaseDate"] as? Date
                let songId = document.reference.documentID
                
                // 呼叫 isFavoriteSong 方法來檢查是否為最愛歌曲
                self.isFavoriteSong(songId: songId) { isFavorite in
                    let song = SongModel(title: title,
                                         artist: artist,
                                         duration: duration,
                                         isFavorite: isFavorite,
                                         releaseDate: releaseDate,
                                         songId: songId)

                    self.newSongs.append(song)
                    print("reuslt song: \(song)")
                    
                    dispatchGroup.leave() // 離開 DispatchGroup
                }
            })

            // 當所有 isFavoriteSong 查詢完成後，執行以下操作
            dispatchGroup.notify(queue: .main) {
                self.updateNewSongsUI()
            }
            
        }

    }
    
    /// Fetch playlist songs from Firestore
    func fetchPlaylistSongs() {
        
        // Fetch songs from Firestore order by releaseDate
        let query = Firestore.firestore().collection("Songs").order(by: "releaseDate", descending: true).limit(to: 4)
        query.getDocuments { snapshot, error in
            
            guard error == nil else {
                print("Error: \(error!.localizedDescription)")
                return
            }
            
            self.playlistSongs.removeAll()
            
            // 使用 DispatchGroup 確保所有 isFavoriteSong 查詢完成後再進行後續操作
            let dispatchGroup = DispatchGroup()
            
            snapshot?.documents.forEach({ document in
                
                dispatchGroup.enter() // 進入 DispatchGroup

                let title = document["title"] as? String
                let artist = document["artist"] as? String
                let duration = document["duration"] as? Double
                let releaseDate = document["releaseDate"] as? Date
                let songId = document.reference.documentID
                
                // 呼叫 isFavoriteSong 方法來檢查是否為最愛歌曲
                self.isFavoriteSong(songId: songId) { isFavorite in
                    let song = SongModel(title: title,
                                         artist: artist,
                                         duration: duration,
                                         isFavorite: isFavorite,
                                         releaseDate: releaseDate,
                                         songId: songId)
                    
                    self.playlistSongs.append(song)
                    print("reuslt song: \(song)")
                    
                    dispatchGroup.leave() // 離開 DispatchGroup
                }
            })
            
            // 當所有 isFavoriteSong 查詢完成後，執行以下操作
            dispatchGroup.notify(queue: .main) {
                self.updatePlaylistSongsUI()
            }
        }
    }
    
    /// Check if the user is sign in
    func isSignIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    /// Check if the song is favorite
    func isFavoriteSong(songId: String, completion: @escaping (Bool) -> Void) {
        
        // 取得 FirebaseAuth 實例
        guard let user = Auth.auth().currentUser else {
            print("使用者未登入")
            completion(false)
            return
        }
        
        // 取得當前使用者的 uid
        let uid = user.uid
        
        // 取得 Firestore 實例
        let firestore = Firestore.firestore()
        
        // 查詢最愛歌曲清單
        firestore.collection("Users")
            .document(uid)
            .collection("Favorites")
            .whereField("songId", isEqualTo: songId)
            .getDocuments { (snapshot, error) in
                if let error = error {
                    print("查詢最愛歌曲時發生錯誤: \(error.localizedDescription)")
                    completion(false)
                } else if let snapshot = snapshot, !snapshot.isEmpty {
                    // 若文件快照不為空，表示歌曲在最愛清單中
                    completion(true)
                } else {
                    // 若文件快照為空，表示歌曲不在最愛清單中
                    completion(false)
                }
            }
    }
    
    /// Add or remove favorite song
    func addOrRemoveFavoriteSong(_ song: SongModel) {

        guard let songId = song.songId else {
            print("歌曲 ID 為空")
            self.delegate?.addOrRemoveFavoriteSongFailure("歌曲 ID 為空")
            return
        }
        
        // 取得 FirebaseAuth 實例
        guard let user = Auth.auth().currentUser else {
            print("使用者未登入")
            self.delegate?.addOrRemoveFavoriteSongFailure("使用者未登入")
            return
        }
        
        // 取得當前使用者的 uid
        let uid = user.uid
        
        // 取得 Firestore 實例
        let firestore = Firestore.firestore()
        
        // 查詢最愛歌曲清單
        firestore.collection("Users")
            .document(uid)
            .collection("Favorites")
            .whereField("songId", isEqualTo: songId)
            .getDocuments { (snapshot, error) in
                
                if let error = error {
                    print("查詢最愛歌曲時發生錯誤: \(error.localizedDescription)")
                    self.delegate?.addOrRemoveFavoriteSongFailure( error.localizedDescription)
                    return
                }
                
                if let snapshot = snapshot, !snapshot.isEmpty {
                    // 若文件快照不為空，表示歌曲在最愛清單中
                    // 移除最愛歌曲
                    snapshot.documents.forEach({ document in
                        firestore.collection("Users")
                            .document(uid)
                            .collection("Favorites")
                            .document(document.documentID)
                            .delete { error in
                                if let error = error {
                                    print("移除最愛歌曲時發生錯誤: \(error.localizedDescription)")
                                    self.delegate?.addOrRemoveFavoriteSongFailure( error.localizedDescription)
                                } else {
                                    print("移除最愛歌曲成功")
                                    self.delegate?.addOrRemoveFavoriteSongSuccess("Remove favorite success.")
                                }
                            }
                    })
                } else {
                    // 若文件快照為空，表示歌曲不在最愛清單中
                    // 加入最愛歌曲
                    firestore.collection("Users")
                        .document(uid)
                        .collection("Favorites")
                        .addDocument(data: ["songId": songId]) { error in
                            if let error = error {
                                print("加入最愛歌曲時發生錯誤: \(error.localizedDescription)")
                                self.delegate?.addOrRemoveFavoriteSongFailure(error.localizedDescription)
                            } else {
                                print("加入最愛歌曲成功")
                                self.delegate?.addOrRemoveFavoriteSongSuccess("Add favorite success.")
                            }
                        }
                }
            }
        
    }
    
}
