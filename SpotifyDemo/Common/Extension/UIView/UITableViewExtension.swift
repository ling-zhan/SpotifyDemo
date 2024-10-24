//
//  UITableViewExtension.swift
//  SpotifyDemo
//
//  Created by Ling Zhan on 2024/9/27.
//

import UIKit

extension UITableView {
    /// 將擴展 UITableViewCell 的 register 方法
    /// - Parameter cellType: UITableViewCell
    /// - Returns: Void
    /// 使用方法 tableView.register(Cell.self)
    func register<T: UITableViewCell>(_ cellType: T.Type) {
        register(cellType.nib, forCellReuseIdentifier: cellType.identifier)
    }
    
    /// 將擴展 UITableViewCell 的 dequeueReusableCell 方法
    /// - Parameters:
    ///  - cell: UITableViewCell
    ///  - indexPath: IndexPath
    ///  - Returns: UITableViewCell
    ///  使用方法 let cell = tableView.dequeueReusableCell(Cell.self, for: indexPath)
    func dequeueReusableCell<T: UITableViewCell>(_: T.Type, for indexPath: IndexPath) -> T {
            guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
                fatalError("Error: Could not dequeue cell with identifier: \(T.identifier)")
            }
            return cell
        }
}
