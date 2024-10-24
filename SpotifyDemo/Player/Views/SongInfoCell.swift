//
//  SongInfoCell.swift
//  SpotifyDemo
//
//  Created by Ling Zhan on 2024/10/1.
//

import UIKit

class SongInfoCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(song: SongModel) {
        self.titleLabel.text = song.title
        self.artistLabel.text = song.artist
        
        
        if let isFavorite = song.isFavorite {
            // 判斷是否為喜歡的歌曲，是的話顯示實心愛心，否則顯示空心愛心
            let image = UIImage(systemName: isFavorite ? "heart.fill" : "heart")
            // 設定圖片
            favoriteButton.setImage(image, for: .normal)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    @IBAction func favoriteButtonTapped(_ sender: Any) {
        print("favoriteButtonTapped")
    }
    
}
