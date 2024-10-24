//
//  AnotherSigninCell.swift
//  SpotifyDemo
//
//  Created by Ling Zhan on 2024/9/12.
//

import UIKit

protocol AnotherSigninCellDelegate: AnyObject {
    /// 到 google 登入
    func didTapGoogleAuth()
    
    /// 到 Apple 登入
    func didTapAppleAuth()
    
    /// 到其它頁面
    func toAnotherViewController()
}

enum AnotherSigninCellType {
    case signin
    case register
}

class AnotherSigninCell: BaseCell {

    @IBOutlet weak var googleAuthView: UIView!
    @IBOutlet weak var appleAuthView: UIView!
    @IBOutlet weak var noteLabel: UILabel!
    
    weak var delegate: AnotherSigninCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        self.configure()
    }

    func configure() {
        self.googleAuthView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapGoogleAuth)))
        
        self.appleAuthView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapAppleAuth)))
        
        // 增加手勢辨識來偵測點擊
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOnLabel(_:)))
        self.noteLabel.addGestureRecognizer(tapGesture)
        self.noteLabel.isUserInteractionEnabled = true
    }
    
    func setContent(_ type: AnotherSigninCellType) {
        switch type {
        case .signin:
            self.noteLabel.attributedText = setSigninText()
        case .register:
            self.noteLabel.attributedText = setRegisterText()
        }
    }
    
    func setSigninText() -> NSMutableAttributedString {
        // 建立可變的 Attributed String
        let attributedString = NSMutableAttributedString(string: "Not A Member ? Register Now")
        
        // 設定 "Register Now" 的範圍
        let linkTextRange = (attributedString.string as NSString).range(of: "Register Now")
        
        // 設定 "Register Now" 的顏色
        attributedString.addAttribute(.foregroundColor, value: UIColor.app_blueE9, range: linkTextRange)
        
        // 設定其他部分的顏色（如果需要）
        let normalTextRange = (attributedString.string as NSString).range(of: "Not A Member ?")
        attributedString.addAttribute(.foregroundColor, value: isDark ? UIColor.app_greyDD : UIColor.app_grey38, range: normalTextRange)
        
        // 設定字型
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 14, weight: .medium), range: NSRange(location: 0, length: attributedString.length))
        
        // 設定文字
        return attributedString
    }
    
    func setRegisterText() -> NSMutableAttributedString {
        // 建立可變的 Attributed String
        let attributedString = NSMutableAttributedString(string: "Do You Have An Account ? Sign In")
        
        // 設定 "Sign In" 的範圍
        let linkTextRange = (attributedString.string as NSString).range(of: "Sign In")
        
        // 設定 "Sign In" 的顏色
        attributedString.addAttribute(.foregroundColor, value: UIColor.signAnotherHinetLink, range: linkTextRange)
        
        // 設定其他部分的顏色（如果需要）
        let normalTextRange = (attributedString.string as NSString).range(of: "Do You Have An Account ?")
        attributedString.addAttribute(.foregroundColor, value: UIColor.signAnotherHinet, range: normalTextRange)
        
        // 設定字型
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 14, weight: .medium), range: NSRange(location: 0, length: attributedString.length))
        
        // 設定文字
        return attributedString
    }
    
    @objc func didTapGoogleAuth() {
        self.delegate?.didTapGoogleAuth()
    }
    
    @objc func didTapAppleAuth() {
        self.delegate?.didTapAppleAuth()
    }
    
    @objc func handleTapOnLabel(_ gesture: UITapGestureRecognizer) {
        delegate?.toAnotherViewController()
    }
    
}
