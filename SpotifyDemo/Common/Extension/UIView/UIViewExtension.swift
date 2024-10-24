//
//  UIViewExtension.swift
//  SpotifyDemo
//
//  Created by Ling Zhan on 2024/9/9.
//

import UIKit

extension UIView {
    
    /// 回傳是否是暗黑模式
    var isDark: Bool {
        return traitCollection.userInterfaceStyle == .dark
    }
}
