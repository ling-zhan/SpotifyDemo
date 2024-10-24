//
//  SigninViewModel.swift
//  SpotifyDemo
//
//  Created by Ling Zhan on 2024/9/19.
//

import Foundation
import FirebaseAuth

protocol SigninViewModelDelegate: AnyObject {
    func signinSuccessed()
    func signinFailed(error: Error)
}

class SigninViewModel {
    var email: String = "testbody@123.com"
    var password: String = "testbody"
    
    weak var delegate: SigninViewModelDelegate?

}

// MARK: - Signin API
extension SigninViewModel {
    
    // Firebase 登入請求
    func signin() {
        
        // 資料驗證
        if !validateEmail() || !validatePassword() {
            self.delegate?.signinFailed(error: HttpError.invalidData)
        }
        
        // 請求
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error {
                self.delegate?.signinFailed(error: error)
            }
            
            if result != nil {
                self.delegate?.signinSuccessed()
            }
        }
    }
    
//    func signout() {
//        do {
//            try Auth.auth().signOut()
//        } catch {
//            print("Error signing out: \(error.localizedDescription)")
//        }
//    }
}

/// 驗證資料
extension SigninViewModel {
    func validateEmail() -> Bool {
        return email.isValidEmail
    }
    
    func validatePassword() -> Bool {
        return password.isValidPassword
    }
}
