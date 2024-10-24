//
//  SignupViewModel.swift
//  SpotifyDemo
//
//  Created by Ling Zhan on 2024/9/20.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol SignupViewModelDelegate: AnyObject {
    func registerSuccessed()
    func registerFailed(error: Error)
}

class SignupViewModel {
    var fullName: String = "TestBody1"
    var email: String = "testbody1@123.com"
    var password: String = "testbody1"
    
    weak var delegate: SignupViewModelDelegate?

}
 
// MARK: - Signup API
extension SignupViewModel {
    
    /// 向 Firebase 註冊使用者
    func register() {
        
        // 資料驗證
        if !validateFullName() || !validateEmail() || !validatePassword() {
            self.delegate?.registerFailed(error: HttpError.invalidData)
        }
        
        // 註冊 使用者
        Auth.auth().createUser(withEmail: email, password: password) { result, error in

            // 錯誤處理
            guard error == nil else {
                self.delegate?.registerFailed(error: HttpError.invalidData)
                return
            }
            
            // 確認使用者是否成功註冊
            guard let user = result?.user else {
                self.delegate?.registerFailed(error: HttpError.invalidResponseData)
                return
            }
            
            // 註冊成功後，將使用者資料存入 Firestore
            Firestore.firestore().collection("Users").document(user.uid).setData(
                ["email": user.email ?? "",
                 "name": self.fullName]
            ) { error in
                if let error = error {
                    self.delegate?.registerFailed(error: HttpError.invalidWriteDatabase)
                    return
                }
                
                self.delegate?.registerSuccessed()
            }
        }
    }
}

// MARK: - 驗證資料
extension SignupViewModel {
    
    func validateFullName() -> Bool {
        return fullName.isValidFullName
    }
    
    func validateEmail() -> Bool {
        return email.isValidEmail
    }
    
    func validatePassword() -> Bool {
        return password.isValidPassword
    }
}
