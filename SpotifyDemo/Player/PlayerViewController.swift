//
//  PlayerViewController.swift
//  SpotifyDemo
//
//  Created by Ling Zhan on 2024/10/1.
//
//  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
//  播放歌曲，基本的目前算是完成
//  實現: 播放/暫停、拖動進度條、以及使用 Timer 來更新播放進度
//  目前實測是沒有 Timer 爆炸的問題，但仍還要持續觀察
//  註： 在播放時 拖動 進度條會卡，但功能正常
//  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

import UIKit
import AVFoundation

protocol PlayerViewControllerDelegate: AnyObject {
    func updateFavoriteSong(row: Int)
}

class PlayerViewController: BaseViewController {
    
    @IBOutlet weak var navigationBar: NavigationBar!
    @IBOutlet weak var navigationBarTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: PlayerViewControllerDelegate?
    let songRow: Int
    
    let viewModel: PlayViewModel

    init(song: SongModel,withRow row: Int) {
        self.viewModel = PlayViewModel(song: song)
        self.songRow = row
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //TODO: - 當畫面結束時，會去更新歌曲是否為最愛
        // 要再看看該怎麼製作!!!!
        self.delegate?.updateFavoriteSong(row: songRow)
    }
    
    // 物件即將被釋放時，結束播放音樂
    deinit {
        self.viewModel.audioPlayer?.stop()
        self.viewModel.stopTimer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel.fetchSong()
    }
    
    override func setupUI() {
        self.viewModel.delegate = self
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.navigationBar.delegate = self
        self.navigationBar.isShowBreakIcon = true
        self.navigationBarTopConstraint.constant = self.statusBarHeight
        
        self.tableViewRegister()
    }
    
    func tableViewRegister() {
        self.tableView.register(SongCoverCell.self)
        self.tableView.register(SongInfoCell.self)
        self.tableView.register(SongOperationlistCell.self)
        self.tableView.register(SpaceCell.self)
    }

    func showAlert(_ title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

}

// MARK: - PlayViewModelDelegate
extension PlayerViewController: PlayViewModelDelegate {
    
    // 下載歌曲完成
    func fetchSongComplete(error: String?) {
        if let error = error {
            self.showAlert("Error", message: error)
        }else {
            self.viewModel.updatePlayProgress()
        }
    }
    
    // 更新 TableCell
    func didUpdateTableCells(_ section: Int, with row: [Int]) {
        DispatchQueue.main.async {
            self.tableView.beginUpdates()
            row.forEach { row in
                self.tableView.reloadRows(at: [IndexPath(row: row, section: section)], with: .none)
            }
            self.tableView.endUpdates()
        }
    }
}

// MARK: - UITableViewDelegate
extension PlayerViewController: NavigationBarDelegate {
    func didTapLeadingButton() {
        // 返回上一頁
        // self.navigationController?.popViewController(animated: true)
        
        // 返回上一頁
        self.dismiss(animated: true)
    }
    
    func didTapTrailingButton() {
        
    }
}

// MARK: - UITableViewDelegate
extension PlayerViewController: UITableViewDelegate {
    
    // height for header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    // height for footer
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        // 回傳最小值
        return CGFloat.leastNormalMagnitude
    }
    
    // view for header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        return header
    }
    
    // view for footer
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let header = UIView()
        return header
    }
}

// MARK: - UITableViewDataSource
extension PlayerViewController: UITableViewDataSource {
    
    // 會寫在這裡，是因為 抓非同步圖片的圖片，會在這裡執行，等圖片抓完後，再更新 cell
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        // 取得歌曲的封面圖片
        if let cell = cell as? SongCoverCell {
            if let url = self.viewModel.song?.getArtistUrl() {
                HttpManager.shared.loadImage(url: url) { data in
                    DispatchQueue.main.async {
                        guard let data = data else { return }
                        let image = UIImage(data: data)
                        cell.uploadCoverImage(coverImage: image!)
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = indexPath.row
        
        switch row {
        case 0:
            let cell = tableView.dequeueReusableCell(SongCoverCell.self, for: indexPath)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(SpaceCell.self, for: indexPath)
            cell.setHeight(height: 17)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(SongInfoCell.self, for: indexPath)
            if let song = self.viewModel.song {
                cell.configure(song: song)
            }
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(SpaceCell.self, for: indexPath)
            cell.setHeight(height: 42)
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(SongOperationlistCell.self, for: indexPath)
            cell.delegate = self
            cell.configure(isCanPlay: self.viewModel.isCanPlay,
                           isPlaying: self.viewModel.isPlaying,
                           currentTime: self.viewModel.currentTime,
                           duration: self.viewModel.duration)
            return cell
        default:
            return UITableViewCell()
        }
        
    }
}

// MARK: - SongOperationlistCellDelegate
extension PlayerViewController: SongOperationlistCellDelegate {
    
    /// slider 開始拖曳
    func sliderDidStartDragging() {
        viewModel.pausePlay()
    }
    
    /// slider 結束拖
    func sliderDidEndDragging(value: TimeInterval) {
        viewModel.seekToTime(time: value)
    }
    
    /// 播放/暫停
    func didTapPlayButton(isPlaying: Bool) {
        self.viewModel.isPlaying = isPlaying
        isPlaying ? self.viewModel.startPlay() : self.viewModel.pausePlay()
    }
    
    func didTapPreviousButton() {
        print("didTapPreviousButton")
    }
    
    func didTapNextButton() {
        print("didTapNextButton")
    }
    
    func didTapShuffleButton() {
        print("didTapShuffleButton")
    }
    
    func didTapRepeateButton() {
        print("didTapRepeateButton")
    }
}
