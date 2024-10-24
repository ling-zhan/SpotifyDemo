//
//  PlaylistCell.swift
//  SpotifyDemo
//
//  Created by Ling Zhan on 2024/9/27.
//

import UIKit

protocol PlaylistCellDelegate: AnyObject {
    func playListSongPlayAt(_ row: Int)
    func playListSongAddFavoriteAt(_ row: Int)
}

class PlaylistCell: UITableViewCell {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    weak var delegate: PlaylistCellDelegate?
    
    var songs: [SongModel] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "SongCell", bundle: nil), forCellReuseIdentifier: "SongCell")
    }
    
    func configure(song: [SongModel]) {
        self.songs = song
        self.activityIndicator.isHidden = self.songs.isEmpty ? false : true
        self.tableView.reloadData()
    }
    
}


extension PlaylistCell: UITableViewDataSource {
    
    // tableview header height 為最小值
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    // tableview flooter height 為最小值
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
}

extension PlaylistCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as! SongCell
        cell.delegate = self
        cell.configure(song: songs[indexPath.row], row: indexPath.row)
        return cell
    }
}

extension PlaylistCell: SongCellDelegate {
    func didTapPlayButton(row: Int) {
        delegate?.playListSongPlayAt(row)
    }
    
    func didTapFavoriteButton(row: Int) {
        delegate?.playListSongAddFavoriteAt(row)
    }
}
