//
//  TabBarCollectionCell.swift
//  SpotifyDemo
//
//  Created by Ling Zhan on 2024/9/26.
//

import UIKit

/**
 * Collection Cell 的畫面因為它的寬與高 都是隨著 CollectionView 的寬與高而變動的
 * 因此在拉畫面時，只考慮將畫面水平與垂直置中，訂出它的高度，然後再去裡面設定
 * 要顯示元件的寬高即可。
 *
 * 目前還是無法研究出來它的寬要怎麼設定
 */

struct TabBarCollectionCellViewModel {
    let title: String
    var isSelected: Bool
}

class TabBarCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var indicatorView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        indicatorView.layer.cornerRadius = indicatorView.frame.height / 2
    }
    
    func configure(_ viewModel: TabBarCollectionCellViewModel) {
        self.titleLabel.text = viewModel.title
        self.indicatorView.isHidden = !viewModel.isSelected
        self.titleLabel.textColor = viewModel.isSelected ? UIColor.homeTabbarSelect : UIColor.homeTabbar
    }

}
