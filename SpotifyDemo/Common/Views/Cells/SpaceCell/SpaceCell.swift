//
//  SpaceCell.swift
//  SpotifyDemo
//
//  Created by Ling Zhan on 2024/9/11.
//

import UIKit

class SpaceCell: BaseCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setHeight(height: CGFloat) {
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
}
