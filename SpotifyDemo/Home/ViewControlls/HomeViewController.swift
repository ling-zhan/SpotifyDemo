//
//  HomeViewController.swift
//  SpotifyDemo
//
//  Created by Ling Zhan on 2024/9/6.
//

import UIKit
import FirebaseCore
import FirebaseAuth

enum SongType {
    case new
    case playlist
}

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var navigationBar: NavigationBar!
    @IBOutlet weak var navigationBarTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if self.viewModel.isSignIn() {
            viewModel.fetchNewsSongs()
            viewModel.fetchPlaylistSongs()
        }
    }
    
    override func setupUI() {
        self.viewModel.delegate = self
        
        self.navigationBar.delegate = self
        self.navigationBar.isShowBreakIcon = false
        self.navigationBarTopConstraint.constant = self.statusBarHeight
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableViewRegister()
    }
    
    func tableViewRegister() {
        // 原生 register 寫法
//        self.tableView.register(UINib(nibName: "HeaderCell", bundle: nil), forCellReuseIdentifier: "HeaderCell")
        
        // 透過擴展 UITableViewCell 的 register 方法，讓程式碼更簡潔
        self.tableView.register(HeaderCell.self)
        self.tableView.register(HorizontalTabBarCell.self)
        self.tableView.register(HorizontalTabBarContentCell.self)
        self.tableView.register(SpaceCell.self)
        self.tableView.register(ScetionCell.self)
        self.tableView.register(PlaylistCell.self)
    }
    
}

// MARK: - Helper
extension HomeViewController {
    // 到播放頁面
    func toPlayViewController(row: Int, songType: SongType) {
        let song: SongModel
        switch songType {
        case .new:
            song = viewModel.newSongs[row]
        case .playlist:
            song = viewModel.playlistSongs[row]
        }
        
        // 使用 navigationController push 到下一頁
//        let vc = PlayerViewController(song: song, withRow: row)
//        self.navigationController?.pushViewController(vc, animated: true)

        // 全畫面 present
        let playerViewController = PlayerViewController(song: song, withRow: row)
        playerViewController.delegate = self
        playerViewController.modalPresentationStyle = .fullScreen
        self.present(playerViewController, animated: true, completion: nil)
    }
    
    // 顯示錯誤訊息
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    // 顯示 Toast
    private func showToast(message : String, font: UIFont) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width / 2 - 100, y: self.view.frame.size.height - 100, width: 200, height: 45))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.numberOfLines = 0
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds  =  true
        
        self.view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}

extension HomeViewController: NavigationBarDelegate {
    func didTapLeadingButton() {
        print("didTapLeadingButton")
    }
    
    func didTapTrailingButton() {
        print("didTapTrailingButton")
    }
}

extension HomeViewController: HomeViewModelDelegate {
    
    func addOrRemoveFavoriteSongSuccess(_ message: String) {
        self.showToast(message: message, font: .systemFont(ofSize: 12))
    }
    
    func addOrRemoveFavoriteSongFailure(_ error: String) {
        self.showErrorAlert(message: error)
    }

    // 更新 TableCell
    func didUpdateTableCells(_ section: Int, with row: [Int]) {
        self.tableView.beginUpdates()
        
        row.forEach { row in
            self.tableView.reloadRows(at: [IndexPath(row: row, section: section)], with: .none)
        }
        
        self.tableView.endUpdates()
    }
}

extension HomeViewController: UITableViewDelegate {
    
    // height for header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 40 : 0
    }
    
    // height for footer
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        // 回傳最小值
        return CGFloat.leastNormalMagnitude
    }
    
    // view for header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let header = UIView()
            return header
        case 1:
            let header = TableSectionView()
            header.configure(leading: "Playlist", trailing: "See More")
            return header
        default:
            let header = UIView()
            return header
        }
    }
    
    // view for footer
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let header = UIView()
        return header
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.tableCells.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableCells[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        let row = indexPath.row
        
        if section == 0 {
            switch row {
            case 0:
                let cell = tableView.dequeueReusableCell(HeaderCell.self, for: indexPath)
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(SpaceCell.self, for: indexPath)
                cell.setHeight(height: 41)
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(HorizontalTabBarCell.self, for: indexPath)
                cell.delegate = self
                cell.scrollToRow = viewModel.taBarScrollToRow
                cell.configure(viewModel.tabBarCellViewModels, scrollToRow: viewModel.taBarScrollToRow)
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(SpaceCell.self, for: indexPath)
                cell.setHeight(height: 28)
                return cell
            case 4:
                let cell = tableView.dequeueReusableCell(HorizontalTabBarContentCell.self, for: indexPath)
                cell.configure(song: viewModel.newSongs)
                cell.delegate = self
                return cell
            case 5:
                let cell = tableView.dequeueReusableCell(SpaceCell.self, for: indexPath)
                cell.setHeight(height: 37)
                return cell
            default:
                return UITableViewCell()
            }
        }else if section == 1 {
            /// 不考慮 row 的樣式
            let cell = tableView.dequeueReusableCell(PlaylistCell.self, for: indexPath)
            cell.configure(song: viewModel.playlistSongs)
            cell.delegate = self
            return cell
            
        }else {
            return UITableViewCell()
        }
        
    }
}

extension HomeViewController: HorizontalTabBarCellDelegate {
    func didSelectTabBarAt(_ row: Int) {
        // 改變 TabBarCollectionCell 的狀態
        viewModel.didSelectItemAt(row)
    }
}


extension HomeViewController: PlaylistCellDelegate {
    func playListSongPlayAt(_ row: Int) {
        self.toPlayViewController(row: row, songType: .playlist)
    }
    
    func playListSongAddFavoriteAt(_ row: Int) {
        // call api add song to favorite
        print("playListSongAddFavoriteAt \(row)")
        
        if let isFavorite = self.viewModel.playlistSongs[row].isFavorite {
            
            self.viewModel.playlistSongs[row].isFavorite = !isFavorite
            self.viewModel.updatePlaylistSongsUI()
            
            self.viewModel.addOrRemoveFavoriteSong(viewModel.playlistSongs[row])
        }
    }
}

extension HomeViewController: HorizontalTabBarContentCellDelegate {
    func newSongPlayAt(_ row: Int) {
        self.toPlayViewController(row: row, songType: .new)
    }
}

extension HomeViewController: PlayerViewControllerDelegate {
    func updateFavoriteSong(row: Int) {
        print("updateFavoriteSong \(row)")
    }
    
}
