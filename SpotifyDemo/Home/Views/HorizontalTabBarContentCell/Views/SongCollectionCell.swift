//
//  SongCollectionCell.swift
//  SpotifyDemo
//
//  Created by Ling Zhan on 2024/9/26.
//

import UIKit

protocol SongCollectionCellDelegate: AnyObject {
    func newSongPlayAt(_ row: Int)
}

class SongCollectionCell: UICollectionViewCell {
    @IBOutlet weak var musicCoverImageView: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
    var row: Int = 0
    weak var delegate: SongCollectionCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // musicCoverImageView 28 圓角
        self.musicCoverImageView.layer.cornerRadius = 28
        self.musicCoverImageView.layer.masksToBounds = true
        
        // playButton 圓角
        let playButtonSize = self.playButton.bounds.size
        self.playButton.layer.cornerRadius = playButtonSize.height / 2
        self.playButton.layer.masksToBounds = true
    }
    
    func configure(song: SongModel, row: Int) {
        self.row = row
        self.titleLabel.text = song.title
        self.artistLabel.text = song.artist
    }
    
    func uploadCoverImage(coverImage: UIImage) {
        self.musicCoverImageView.image = coverImage
    }

    @IBAction func playButtonDidTap(_ sender: Any) {
        self.delegate?.newSongPlayAt(row)
    }
    
}
