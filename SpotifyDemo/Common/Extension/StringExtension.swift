//
//  StringExtension.swift
//  SpotifyDemo
//
//  Created by Ling Zhan on 2024/9/19.
//

import Foundation

// MARK: - String Verify Extension
extension String {
    
    var isValidFullName: Bool {
        return self.count >= 2
    }
    
    var isValidEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
    
    var isValidPassword: Bool {
        return self.count >= 6
    }
}
