//
//  RoundTextField.swift
//  SpotifyDemo
//
//  Created by Ling Zhan on 2024/9/11.
//

import UIKit

class RoundTextField: UIView {
    
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
        return textField
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
        
        // set constraints
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            textField.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            textField.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -16),
            textField.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor)
        
        ])
        
        // 設定 backgroundView 增加邊框與圓角
        backgroundView.layer.borderWidth = 1
        backgroundView.layer.borderColor = UIColor.appTextfieldBorder.cgColor
        backgroundView.layer.cornerRadius = 30

        // 設定 textField textColor
        textField.textColor = UIColor.appTextfieldText
    }
}
