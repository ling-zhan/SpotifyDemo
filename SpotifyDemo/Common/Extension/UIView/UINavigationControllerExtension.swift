//
//  UINavigationControllerExtension.swift
//  SpotifyDemo
//
//  Created by Ling Zhan on 2024/9/12.
//

import UIKit

extension UINavigationController {
    
    /// 推送至下一個 ViewController 並移除當前的 ViewController
    func pushAndRemoveCurrentViewController(_ viewController: UIViewController, animated: Bool = true) {
        // 推送新的視圖控制器
        self.pushViewController(viewController, animated: animated)
        
        var viewControllers = self.viewControllers
        // 確保有足夠的控制器在堆疊中
        if viewControllers.count > 1 {
            // 移除當前控制器 (也就是倒數第二個控制器)
            viewControllers.remove(at: viewControllers.count - 2)
            self.viewControllers = viewControllers
        }
    }
    
    /// 推送至下一個 ViewController 並移除指定的 ViewController
    func pushAndRemoveViewController(_ viewController: UIViewController, removeViewController: UIViewController, animated: Bool = true) {
        // 推送新的視圖控制器
        self.pushViewController(viewController, animated: animated)
        
        var viewControllers = self.viewControllers
        // 移除指定的控制器
        if let index = viewControllers.firstIndex(of: removeViewController) {
            viewControllers.remove(at: index)
            self.viewControllers = viewControllers
        }
    }
}
