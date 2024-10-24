//
//  HorizontalTabBarCell.swift
//  SpotifyDemo
//
//  Created by Ling Zhan on 2024/9/25.
//

import UIKit

protocol HorizontalTabBarCellDelegate: AnyObject {
    func didSelectTabBarAt(_ row: Int)
}

class HorizontalTabBarCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: HorizontalTabBarCellDelegate?
    
    var cellViewModels: [TabBarCollectionCellViewModel] = []
    var scrollToRow: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionViewRegister()
    }
    
    // 當畫面載好時，才執行的生命週期
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    
    func configure(_ cellViewModels: [TabBarCollectionCellViewModel], scrollToRow: Int) {
        self.cellViewModels = cellViewModels
        
        self.collectionView.reloadData()
        let indexPath = IndexPath(row: scrollToRow, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
    }
    
    func collectionViewRegister() {
        self.collectionView.register(UINib(nibName: "TabBarCollectionCell", bundle: nil), forCellWithReuseIdentifier: "TabBarCollectionCell")
    }
    
}

extension HorizontalTabBarCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TabBarCollectionCell", for: indexPath) as! TabBarCollectionCell
        cell.configure(self.cellViewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cellViewModels.count
    }

    // 設定 selected
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didSelectTabBarAt(indexPath.row)
    }
    
}
