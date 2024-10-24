//
//  IntroViewController.swift
//  SpotifyDemo
//
//  Created by Ling Zhan on 2024/9/6.
//

import UIKit

class IntroViewController: BaseViewController {
    
    @IBOutlet var getStartedButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func setupUI() {
        self.getStartedButton.layer.cornerRadius = 30
        self.getStartedButton.layer.masksToBounds = true
    }

    @IBAction func getStartedButtonTapped(_ sender: Any) {
        let vc = ModelSelectViewController()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
