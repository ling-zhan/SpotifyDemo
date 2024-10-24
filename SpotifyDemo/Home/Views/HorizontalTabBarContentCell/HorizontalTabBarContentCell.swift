//
//  HorizontalTabBarContentCell.swift
//  SpotifyDemo
//
//  Created by Ling Zhan on 2024/9/26.
//

import UIKit

protocol HorizontalTabBarContentCellDelegate: AnyObject {
    func newSongPlayAt(_ row: Int)
}

class HorizontalTabBarContentCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var delegate: HorizontalTabBarContentCellDelegate?
    
    var songs: [SongModel] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionViewRegister()
    }
    
    func configure(song: [SongModel]) {
        self.songs = song
        self.activityIndicator.isHidden = self.songs.isEmpty ? false : true
        self.collectionView.reloadData()
    }

    func collectionViewRegister() {
        self.collectionView.register(UINib(nibName: "SongCollectionCell", bundle: nil), forCellWithReuseIdentifier: "SongCollectionCell")
    }
    
}

extension HorizontalTabBarContentCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // 會寫在這裡，是因為 抓非同步圖片的圖片，會在這裡執行，等圖片抓完後，再更新 cell
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        // 取得歌曲的封面圖片
        if let url = songs[indexPath.row].getArtistUrl() {
            HttpManager.shared.loadImage(url: url) { data in
                DispatchQueue.main.async {
                    guard let data = data else { return }
                    let image = UIImage(data: data)
                    
                    // 從 collectionView 的 indexPath 取得 SongCollectionCell
                    if let cell = collectionView.cellForItem(at: indexPath) as? SongCollectionCell {
                        cell.uploadCoverImage(coverImage: image!)
                    }
                }
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SongCollectionCell", for: indexPath) as! SongCollectionCell
        cell.configure(song: songs[indexPath.row], row: indexPath.row)
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return songs.count
    }
}

extension HorizontalTabBarContentCell: SongCollectionCellDelegate {
    func newSongPlayAt(_ row: Int) {
        self.delegate?.newSongPlayAt(row)
    }
}
