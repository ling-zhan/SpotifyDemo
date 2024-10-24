//
//  DividerCell.swift
//  SpotifyDemo
//
//  Created by Ling Zhan on 2024/9/11.
//

import UIKit

class DividerCell: BaseCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var leadingView: UIView!
    @IBOutlet weak var trailingView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
 
        self.configure()
    }
    
    func configure() {
        self.titleLabel.textColor = UIColor.signDivider
        self.leadingView.backgroundColor = UIColor.signDivider
        self.trailingView.backgroundColor = UIColor.signDivider
    }

}
