//
//  ColorExtension.swift
//  SpotifyDemo
//
//  Created by Ling Zhan on 2024/9/9.
//

import UIKit

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

extension UIColor {
    
    static var app_blueE9: UIColor {
        return UIColor(hexString: "288CE9")
    }
    
    static var app_dark2C: UIColor {
        return UIColor(hexString: "2C2C2C")
    }
    
    static var app_dark22: UIColor {
        return UIColor(hexString: "232222")
    }
    
    static var app_dark07: UIColor {
        return UIColor(hexString: "070707")
    }
    
    static var app_green3C: UIColor {
        return UIColor(hexString: "42C83C")
    }
    
    static var app_green32: UIColor {
        return UIColor(hexString: "38B432")
    }
    
    static var app_grey34: UIColor {
        return UIColor(hexString: "343434")
    }
    
    static var app_grey38: UIColor {
        return UIColor(hexString: "383838")
    }
    
    static var app_grey61: UIColor {
        return UIColor(hexString: "616161")
    }
    
    static var app_grey79: UIColor {
        return UIColor(hexString: "797979")
    }
    
    static var app_grey8D: UIColor {
        return UIColor(hexString: "8D8D8D")
    }
    
    static var app_grey95: UIColor {
        return UIColor(hexString: "959595")
    }
    
    static var app_greyA0: UIColor {
        return UIColor(hexString: "A0A0A0")
    }
    
    static var app_greyA7: UIColor {
        return UIColor(hexString: "A7A7A7")
    }
    
    static var app_greyCF: UIColor {
        return UIColor(hexString: "CFCFCF")
    }
    
    static var app_greyD6: UIColor {
        return UIColor(hexString: "D6D6D6")
    }
    
    static var app_greyDA: UIColor {
        return UIColor(hexString: "DADADA")
    }
    
    static var app_greyE1: UIColor {
        return UIColor(hexString: "E1E1E1")
    }
    
    static var app_greyE4: UIColor {
        return UIColor(hexString: "E4E4E4")
    }
    
    static var app_greyF6: UIColor {
        return UIColor(hexString: "F6F6F6")
    }
    
    static var app_grey41: UIColor {
        return UIColor(hexString: "414141")
    }
    
    static var app_greyDD: UIColor {
        return UIColor(hexString: "DDDDDD")
    }
    
    
    static var app_white004: UIColor {
        return UIColor(hexString: "000000").withAlphaComponent(0.04)
    }
}
