//
//  ScetionCell.swift
//  SpotifyDemo
//
//  Created by Ling Zhan on 2024/9/26.
//

import UIKit

class ScetionCell: UITableViewCell {
    
    @IBOutlet weak var leadingLabel: UILabel!
    @IBOutlet weak var trailingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(leadingTitle: String, trailingTitle: String) {
        leadingLabel.text = leadingTitle
        trailingLabel.text = leadingTitle
    }
    
}
