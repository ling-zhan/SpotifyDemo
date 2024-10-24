//
//  TableSectionView.swift
//  SpotifyDemo
//
//  Created by Ling Zhan on 2024/9/26.
//

import UIKit

/**
 * UIView xib 的用法
 * 1. 在 xib File's Owner -> Class 輸入 TableSectionView 該名稱
 * 2. 然後將 contentView 指在最外層那個 View
 * 3. 加入 override init(frame: CGRect) { }
 * 4. 加入 required init?(coder: NSCoder) { }
 * 5. 加入 private func commonInit() { } 方法，裡面的程式碼即為固定
 *
 *  即可在 TalbeView 的 Header 使用 let view = TableSectionView() 生成即可
 *  或要自行創建 大小及寬度 let view = TableSectionView(frame: CGRect(...)) 即可
 */

class TableSectionView: UIView {
    
    @IBOutlet var contentView: UIView!  // XIB 主要的 content view
    @IBOutlet weak var leadingLabel: UILabel!
    @IBOutlet weak var trailingLabel: UILabel!
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            commonInit()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            commonInit()
        }
        
        // 共通初始化方法，用來加載 XIB
        private func commonInit() {
            // 從 XIB 加載
            Bundle.main.loadNibNamed("TableSectionView", owner: self, options: nil)
            // 將 XIB 的 contentView 加入當前視圖
            addSubview(contentView)
            // 設置 contentView 的大小與當前 UIView 一致
            contentView.frame = self.bounds
            contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
    
    func configure(leading: String, trailing: String) {
        leadingLabel.text = leading
        trailingLabel.text = trailing
    }
}
