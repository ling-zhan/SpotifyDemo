//
//  SongOperationlistCell.swift
//  SpotifyDemo
//
//  Created by Ling Zhan on 2024/10/1.
//

import UIKit

protocol SongOperationlistCellDelegate: AnyObject {
    /// 播放/暫停
    func didTapPlayButton(isPlaying: Bool)
    
    /// 上一首
    func didTapPreviousButton()
    
    /// 下一首
    func didTapNextButton()
    
    /// 洗牌
    func didTapShuffleButton()
    
    /// 重複
    func didTapRepeateButton()
    
    /// slider 開始拖動
    func sliderDidStartDragging()
    
    /// slider 結束拖動
    func sliderDidEndDragging(value: TimeInterval)
}

class SongOperationlistCell: UITableViewCell {
    @IBOutlet weak var progressSlider: UISlider!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var shuffleButton: UIButton!
    @IBOutlet weak var repeateButton: UIButton!
    
    weak var delegate: SongOperationlistCellDelegate?
    
    var isCanPlay: Bool = false
    
    var isPlaying: Bool = false {
        didSet {
            if isPlaying {
                self.playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            } else {
                self.playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // playButton 圓形
        self.playButton.layer.cornerRadius = self.playButton.frame.width / 2
        self.playButton.layer.masksToBounds = true
        
        // 初始化按鈕狀態
        self.isShowCanPlayUI(isCanPlay)
    }

    func configure(isCanPlay: Bool, isPlaying: Bool, currentTime: TimeInterval, duration: TimeInterval) {
        self.isPlaying = isPlaying
        
        // 設定 Slider 當前值
        self.progressSlider.value = Float(currentTime)
        // 設定 Slider 的最大值
        self.progressSlider.maximumValue = Float(duration)
        
        // 設定 Label 的文字
        self.progressLabel.text = timeString(time: currentTime)
        self.totalLabel.text = timeString(time: duration)
        
        // 更新按鈕狀態
        self.isShowCanPlayUI(isCanPlay)
    }
    
    func isShowCanPlayUI(_ isCanPlay: Bool) {
        self.isCanPlay = isCanPlay
        
        self.playButton.isEnabled = isCanPlay
        self.playButton.layer.backgroundColor = isCanPlay ? UIColor.appGreenBtnBackground.cgColor : UIColor.lightGray.withAlphaComponent(0.5).cgColor
        
        self.previousButton.isEnabled = isCanPlay
        self.nextButton.isEnabled = isCanPlay
        self.shuffleButton.isEnabled = isCanPlay
        self.repeateButton.isEnabled = isCanPlay
        
        self.progressSlider.isEnabled = isCanPlay
    }
    
    /// 轉換時間格式
    func timeString(time: TimeInterval) -> String {
        let minute = Int(time) / 60
        let second = Int(time) % 60
        return String(format: "%02d:%02d", minute, second)
    }
    
}

//MARK: - IBAction
extension SongOperationlistCell {
    @IBAction func playButtonTapped(_ sender: Any) {
        self.isPlaying.toggle()
        self.delegate?.didTapPlayButton(isPlaying: self.isPlaying)
    }
    
    @IBAction func previousButtonTapped(_ sender: Any) {
        self.delegate?.didTapPreviousButton()
    }
        
    @IBAction func nextButtonTapped(_ sender: Any) {
        self.delegate?.didTapNextButton()
    }
        
    @IBAction func shuffleButtonTapped(_ sender: Any) {
        self.delegate?.didTapShuffleButton()
    }
    
    @IBAction func repeateButtonTapped(_ sender: Any) {
        self.delegate?.didTapRepeateButton()
    }
    
    // 開始拖動 Slider(互動事件為 .touchDown)
    @IBAction func sliderDidStartDragging(_ sender: UISlider) {
        // 在這裡可以暫停播放器或其他操作
        self.isPlaying = false
        self.delegate?.sliderDidStartDragging()
    }
    
    // 結束拖動 Slider(互動事件為 [.touchUpInside, .touchUpOutside])
    @IBAction func sliderDidEndDragging(_ sender: UISlider) {
        // 在這裡可以繼續播放器或其他操作
        self.isPlaying = true
        self.delegate?.sliderDidEndDragging(value: TimeInterval(sender.value))
    }
}
