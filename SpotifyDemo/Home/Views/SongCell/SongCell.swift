//
//  SongCell.swift
//  SpotifyDemo
//
//  Created by Ling Zhan on 2024/9/26.
//

import UIKit

protocol SongCellDelegate: AnyObject {
    func didTapPlayButton(row: Int)
    func didTapFavoriteButton(row: Int)
}

class SongCell: UITableViewCell {

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    weak var delegate: SongCellDelegate?
    var row: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        playButton.layer.cornerRadius = playButton.bounds.size.height / 2
        playButton.layer.masksToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(song: SongModel, row: Int) {
        self.row = row
        
        titleLabel.text = song.title
        artistLabel.text = song.artist
        durationLabel.text = song.getDuration()

        if let isFavorite = song.isFavorite {
            // 設定圖片為 small 小號
            let configuration = UIImage.SymbolConfiguration(scale: .small)
            // 判斷是否為喜歡的歌曲，是的話顯示實心愛心，否則顯示空心愛心
            let image = UIImage(systemName: isFavorite ? "heart.fill" : "heart", withConfiguration: configuration)
            // 設定圖片
            favoriteButton.setImage(image, for: .normal)
        }
    }
    
    @IBAction func playButtonTapped(_ sender: Any) {
        self.delegate?.didTapPlayButton(row: row)
    }
    
    @IBAction func favoriteButtonTapped(_ sender: Any) {
        self.delegate?.didTapFavoriteButton(row: row)
    }
}
