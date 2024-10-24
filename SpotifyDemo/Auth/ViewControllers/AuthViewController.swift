//
//  AuthViewController.swift
//  SpotifyDemo
//
//  Created by Ling Zhan on 2024/9/9.
//

import UIKit

class AuthViewController: BaseViewController {

    @IBOutlet weak var navigationBar: NavigationBar!
    @IBOutlet weak var navigationBarTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var signinButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setupUI() {
        self.navigationBar.delegate = self
        self.navigationBarTopConstraint.constant = self.statusBarHeight
        self.navigationBar.isHaveTrailingIcon = false
        
        self.registerButton.layer.cornerRadius = 30
        self.registerButton.layer.masksToBounds = true
    }
    
    @IBAction func didTapRegisterButton(_ sender: UIButton) {
        let vc = SignupViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didTapSigninButton(_ sender: UIButton) {
        let vc = SigninViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

extension AuthViewController: NavigationBarDelegate {
    func didTapLeadingButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func didTapTrailingButton() {
        
    }
}
