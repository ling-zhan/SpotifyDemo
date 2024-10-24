//
//  RegisterTitleCell.swift
//  SpotifyDemo
//
//  Created by Ling Zhan on 2024/9/12.
//

import UIKit

class RegisterTitleCell: BaseCell {
    
    @IBOutlet weak var noteLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.configure()
    }
    
    func configure() {

        noteLabel.isUserInteractionEnabled = true
        
        // 建立可變的 Attributed String
        let attributedString = NSMutableAttributedString(string: "If You Need Any Support Click Here")
        
        // 設定 "Click Here" 的範圍
        let linkTextRange = (attributedString.string as NSString).range(of: "Click Here")
        
        // 設定 "Click Here" 的顏色
        attributedString.addAttribute(.foregroundColor, value: UIColor.signHinetLink, range: linkTextRange)
        
        // 設定其他部分的顏色（如果需要）
        let normalTextRange = (attributedString.string as NSString).range(of: "If You Need Any Support")
        attributedString.addAttribute(.foregroundColor, value: UIColor.signHinet, range: normalTextRange)
        
        // 設定字型
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 12), range: NSRange(location: 0, length: attributedString.length))
        
        // 設定文字
        noteLabel.attributedText = attributedString
        
        // 增加手勢辨識來偵測點擊
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOnLabel(_:)))
        noteLabel.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTapOnLabel(_ gesture: UITapGestureRecognizer) {
        // 目前僅能做到整個 label 超連結這樣!
        if let url = URL(string: "https://www.google.com") {
            UIApplication.shared.open(url)
        }
    }
    
}
