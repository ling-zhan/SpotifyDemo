//
//  RoundSecretTextField.swift
//  SpotifyDemo
//
//  Created by Ling Zhan on 2024/9/11.
//

import UIKit

class RoundSecretTextField:UIView {
    
    @IBInspectable var placeholder: String? {
        didSet {
            textField.placeholder = placeholder
        }
    }

    private let backgroundView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // create textfield
    public let textField: UITextField = {
        let textField = UITextField()
        // autocapitalizationType: 是否自動大寫
        textField.autocapitalizationType = .none
        // autocorrectionType: 是否自動修正
        textField.autocorrectionType = .no
        // translatesAutoresizingMaskIntoConstraints: 是否停用自動佈局
        textField.translatesAutoresizingMaskIntoConstraints = false
        //isSecureTextEntry: 是否為安全文字輸入
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let eyeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eye.slash")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = UIColor.app_grey8D
        button.setTitle("", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        addSubview(backgroundView)
        backgroundView.addSubview(textField)
        backgroundView.addSubview(eyeButton)
        
        // set constraints
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            textField.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            textField.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: eyeButton.leadingAnchor, constant: -8),
            textField.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor),
            
            eyeButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            eyeButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -28),
            eyeButton.widthAnchor.constraint(equalToConstant: 24),
            eyeButton.heightAnchor.constraint(equalToConstant: 24)
        
        ])

        // 設定 backgroundView 增加邊框與圓角
        backgroundView.layer.borderWidth = 1
        backgroundView.layer.borderColor = UIColor.appTextfieldBorder.cgColor
        backgroundView.layer.cornerRadius = 30

        // 設定 textField textColor
        textField.textColor = UIColor.appTextfieldText
        
        eyeButton.addTarget(self, action: #selector(eyeButtonTapped), for: .touchUpInside)
    }
    
    @objc func eyeButtonTapped() {
        isSecureTextEntry(!textField.isSecureTextEntry)
    }
    
    func isSecureTextEntry(_ isSecure: Bool) {
        textField.isSecureTextEntry = isSecure
        let image = UIImage(systemName: isSecure ? "eye.slash" : "eye")?.withRenderingMode(.alwaysTemplate)
        eyeButton.setImage(image, for: .normal)
    }
}
