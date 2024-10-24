//
//  UITableViewCellExtension.swift
//  SpotifyDemo
//
//  Created by Ling Zhan on 2024/9/27.
//

import UIKit

extension UITableViewCell {
    /// 取得 UITableViewCell 自已的 identifier
    static var identifier: String {
        return String(describing: self)
    }

    /// 取得 UITableViewCell 自已的 UINib
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}
