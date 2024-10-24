//
//  UIViewControllerExtension.swift
//  SpotifyDemo
//
//  Created by Ling Zhan on 2024/9/25.
//

import UIKit

extension UIViewController {
    
    /// 取得系統的 nab bar 的高度
    var navigationBarHeight: CGFloat {
        return self.navigationController?.navigationBar.frame.height ?? 0
    }
    
    /// 取得系統的 status bar 的高度
    var statusBarHeight: CGFloat {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            return windowScene.statusBarManager?.statusBarFrame.height ?? 0
        }else {
            return 0
        }
    }
}
