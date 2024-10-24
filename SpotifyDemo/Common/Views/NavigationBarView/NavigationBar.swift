//
//  NavigationBar.swift
//  SpotifyDemo
//
//  Created by Ling Zhan on 2024/9/9.
//

import UIKit

protocol NavigationBarDelegate: NSObject {
    func didTapLeadingButton()
    func didTapTrailingButton()
}

@IBDesignable
class NavigationBar: UIView {
    
    @IBInspectable var navIcon: UIImage? {
        didSet {
            imageView.image = navIcon
        }
    }
    
    @IBInspectable var isShowBreakIcon: Bool = true {
        didSet {
            let image = isShowBreakIcon ? UIImage(systemName: "chevron.left") : UIImage(systemName: "magnifyingglass")
            
            leadingButton.setImage(image, for: .normal)
        }
    }
    
    @IBInspectable var isHaveLeadingIcon: Bool = true {
        didSet {
            leadingButton.isHidden = !isHaveLeadingIcon
        }
    }
    
    @IBInspectable var isHaveTrailingIcon: Bool = true {
        didSet {
            trailingButton.isHidden = !isHaveTrailingIcon
        }
    }
    
    @IBInspectable var isShowLogo: Bool = true {
        didSet {
            imageView.isHidden = !isShowLogo
        }
    }

    let buttonSize: CGSize = CGSize(width: 34, height: 34)
    weak var delegate: NavigationBarDelegate?

    // create leading icon UIButton
    private let leadingButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    // create trailing icon UIButton
    private let trailingButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        return button
    }()
    
    // image view
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "spotify_logo")
        return imageView
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    //MARK: - Public func
    
    func setup() {
        // add subviews
        addSubview(leadingButton)
        addSubview(imageView)
        addSubview(trailingButton)
        
        self.backgroundColor = .clear
        
        // set constraints
        NSLayoutConstraint.activate([

            // 設定 leadingButton 位置: 垂直置中，左邊距離 34，寬高 34
            leadingButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 34),
            leadingButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            leadingButton.widthAnchor.constraint(equalToConstant: buttonSize.width),
            leadingButton.heightAnchor.constraint(equalToConstant: buttonSize.height),
            
            // 設定 imageView 位置: 垂直置中，水平置中，寬高 34
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 34),
            
            // 設定 trailingButton 位置: 垂直置中，右邊距離 34，寬高 34
            trailingButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -34),
            trailingButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            trailingButton.widthAnchor.constraint(equalToConstant: buttonSize.width),
            trailingButton.heightAnchor.constraint(equalToConstant: buttonSize.height),
            
        ])
        
        // set iconButton style
        leadingButton.layer.cornerRadius = buttonSize.height / 2
        leadingButton.layer.masksToBounds = true
        
        leadingButton.tintColor = UIColor.appNavbarIcon
        leadingButton.backgroundColor = UIColor.appNavbarIconBackground
        
        let image = isShowBreakIcon ? UIImage(systemName: "chevron.left") : UIImage(systemName: "magnifyingglass")
        leadingButton.setImage(image, for: .normal)
        
        trailingButton.layer.masksToBounds = true
        trailingButton.tintColor = UIColor.appNavbarIcon
        
        // 禁用自動佈局
        leadingButton.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        trailingButton.translatesAutoresizingMaskIntoConstraints = false
        
        // add target
        self.leadingButton.addTarget(self, action: #selector(handleLeadingButtonTap), for: .touchUpInside)
        self.trailingButton.addTarget(self, action: #selector(handleTrailingButtonTap), for: .touchUpInside)
        
    }

    /// 按鈕事件 呼叫 delegate didTapLeadingButton 方法
    @objc func handleLeadingButtonTap() {
        delegate?.didTapLeadingButton()
    }
    
    /// 按鈕事件 呼叫 delegate didTapTrailingButton 方法
    @objc func handleTrailingButtonTap() {
        delegate?.didTapTrailingButton()
    }
    
    
}
