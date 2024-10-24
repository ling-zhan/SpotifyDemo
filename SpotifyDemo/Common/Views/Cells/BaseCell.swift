//
//  BaseCell.swift
//  SpotifyDemo
//
//  Created by Ling Zhan on 2024/9/19.
//

import UIKit


/**
 * 為了要讓 組成 Cell 的元件，都擁有關掉鍵盤的功能
 * 因此在這裡建立一個 BaseCell，並且建立一個 BaseCellDelegate
 * 所有的 Cell只要繼承 BaseCell，並實作 Delegate，就可以擁有關掉鍵盤的該方法
 */

protocol BaseCellDelegate: AnyObject {
    func closeKeyboard()
}

class BaseCell: UITableViewCell {
    
    weak var baseDelegate: BaseCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 增加點擊手勢，點擊空白處收起鍵盤
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        self.addGestureRecognizer(tap)
    }

    @objc func closeKeyboard() {
        baseDelegate?.closeKeyboard()
    }
    
}
