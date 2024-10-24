//
//  ModelSelectViewController.swift
//  SpotifyDemo
//
//  Created by Ling Zhan on 2024/9/9.
//

import UIKit

class ModelSelectViewController: BaseViewController {
    
    @IBOutlet weak var darkModelButton: CircleIconButton!
    @IBOutlet weak var lightModelButton: CircleIconButton!
    @IBOutlet weak var continueButton: UIButton!
    
    var modelTypeTag: Int?
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setupUI() {
        self.continueButton.layer.cornerRadius = 30
        self.continueButton.layer.masksToBounds = true
        
        darkModelButton.delegate = self
        lightModelButton.delegate = self
    }
    
    @IBAction func continueButtonTapped(_ sender: Any) {
        let vc = AuthViewController()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ModelSelectViewController: CircleIconButtonDelegate {
    func didTapButton(self: CircleIconButton) {
        
        if self == darkModelButton {
            appDelegate.setAppModelType(isDark: true)
        } else if self == lightModelButton {
            appDelegate.setAppModelType(isDark: false)
        } else {
            return
        }
    }
    
}
