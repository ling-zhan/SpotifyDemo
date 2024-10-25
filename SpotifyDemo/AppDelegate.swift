//
//  AppDelegate.swift
//  SpotifyDemo
//
//  Created by Ling Zhan on 2024/10/23.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.toIntroViewController()
        self.setAppModelType(isDark: nil)
        return true
    }
    
    func toTestViewController() {
        let vc = SigninViewController()
        
        let navi = UINavigationController(rootViewController: vc)
        self.window?.rootViewController = navi
        
        self.window?.backgroundColor = .white
        self.window?.makeKeyAndVisible()
    }
    
    func toHomeViewController() {
        let vc = HomeViewController()
        
        let navi = UINavigationController(rootViewController: vc)
        self.window?.rootViewController = navi
        
        self.window?.backgroundColor = .white
        self.window?.makeKeyAndVisible()
    }
    
    func toIntroViewController() {
        let vc = IntroViewController()
        
        let navi = UINavigationController(rootViewController: vc)
        self.window?.rootViewController = navi
        
        self.window?.backgroundColor = .white
        self.window?.makeKeyAndVisible()
    }
    
    /// 設定 App Model Type
    func setAppModelType(isDark: Bool?) {
        
        var isDarkModel: Bool {
            set {
                UserDefaults.standard.set(newValue, forKey: "isDark")
            }
            
            get {
                return UserDefaults.standard.bool(forKey: "isDark")
            }
        }
        
        if let isDark = isDark {
            isDarkModel = isDark
        }

        // iOS 15 以上使用這個 UIWindowScene
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let windows = windowScene.windows
            if isDarkModel {
                windows.forEach { window in
                    window.overrideUserInterfaceStyle = .dark
                }
            } else {
                windows.forEach { window in
                    window.overrideUserInterfaceStyle = .light
                }
            }
        }
        
    }


}

