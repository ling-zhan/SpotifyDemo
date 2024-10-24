//
//  BaseViewController.swift
//  SpotifyDemo
//
//  Created by Ling Zhan on 2024/9/9.
//

import UIKit

class BaseViewController: UIViewController {
    
    /// 是否隱藏 NavigationBar
    var navBarHidden: Bool = true
    
    /// AppDelegate
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 隱藏 NavigationBar
    /// 在 override viewWillAppear 之前，一定要執行 super.viewWillAppear(animated)，該行
    /// 因為這樣它才會調用父類的 viewWillAppear 方法，這樣讓底下 setNavigationBarHidden 代碼會先被執行
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(navBarHidden, animated: false)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.appBackground
        
        self.setupUI()
    }
    
    public func setupUI() {
        
    }
}
