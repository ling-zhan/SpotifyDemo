//
//  CircleIconButton.swift
//  SpotifyDemo
//
//  Created by Ling Zhan on 2024/9/9.
//

import UIKit

protocol CircleIconButtonDelegate: NSObject {
    func didTapButton(self: CircleIconButton)
}

@IBDesignable
class CircleIconButton: UIView {
    
    @IBInspectable var icon: UIImage? {
        didSet {
            iconView.image = icon
        }
    }
    
    @IBInspectable var iconTintColor: UIColor? {
        didSet {
            iconView.tintColor = iconTintColor
        }
    }
    
    @IBInspectable var text: String? {
        didSet {
            label.text = text
        }
    }
    
    @IBInspectable var textColor: UIColor? {
        didSet {
            label.textColor = textColor
        }
    }
    
    let circleViewSize: CGSize = CGSize(width: 73, height: 73)
    let iconViewSize: CGSize = CGSize(width: 36, height: 36)
    
    weak var delegate: CircleIconButtonDelegate?
    
    // create circle uiview
    private let circleView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.masksToBounds = true
        return view
    }()
    
    private let iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // create text label
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
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
        addSubview(circleView)
        addSubview(label)
        
        // set background
        self.backgroundColor = .clear
        
        // set iconButton style
        let blurEffect = UIBlurEffect(style: .systemMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = circleView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        circleView.addSubview(blurEffectView)
        circleView.addSubview(iconView)
        circleView.layer.cornerRadius = circleViewSize.height / 2
        
        // set constraints
        NSLayoutConstraint.activate([
            circleView.topAnchor.constraint(equalTo: topAnchor),
            circleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            circleView.widthAnchor.constraint(equalToConstant: circleViewSize.width),
            circleView.heightAnchor.constraint(equalToConstant: circleViewSize.height),
            
            iconView.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            iconView.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: iconViewSize.width),
            iconView.heightAnchor.constraint(equalToConstant: iconViewSize.height),
            
            
            label.topAnchor.constraint(equalTo: circleView.bottomAnchor, constant: 17),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        

        
        // 禁用自動佈局
        circleView.translatesAutoresizingMaskIntoConstraints = false
        iconView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        // add tap gesture
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tap)
        self.addGestureRecognizer(tap)
        
    }

    /// 按鈕事件 呼叫 delegate didTapButton 方法
    @objc func handleTap() {
        delegate?.didTapButton(self: self)
    }
}
