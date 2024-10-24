//
//  SongCoverCell.swift
//  SpotifyDemo
//
//  Created by Ling Zhan on 2024/10/1.
//

import UIKit

class SongCoverCell: UITableViewCell {
    
    @IBOutlet weak var coverImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.coverImageView.layer.cornerRadius = 28
        self.coverImageView.layer.masksToBounds = true
        
    }
    
    func uploadCoverImage(coverImage: UIImage) {
        self.coverImageView.image = coverImage
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
