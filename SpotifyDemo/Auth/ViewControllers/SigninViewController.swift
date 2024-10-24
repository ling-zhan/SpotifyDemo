//
//  SigninViewController.swift
//  SpotifyDemo
//
//  Created by Ling Zhan on 2024/9/10.
//

import UIKit

class SigninViewController: BaseViewController {
    
    @IBOutlet weak var navigationBar: NavigationBar!
    @IBOutlet weak var navigationBarTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let viewModel: SigninViewModel = .init()
    
    /* 因為要取得 cell 裡面 textfield 輸入的內容，所以要宣告 cell 變數，隨後再指定 */
    var emailTextFieldCell: EmailTextFieldCell = .init()
    var passwordTextFieldCell: PasswordTextFieldCell = .init()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setupUI() {
        self.navigationBar.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.viewModel.delegate = self
        
        self.navigationBarTopConstraint.constant = self.statusBarHeight
        self.navigationBar.isHaveTrailingIcon = false
        
        self.tableViewRegister()
    }
    
    func tableViewRegister() {
//        self.tableView.register(UINib(nibName: "EmailTextFieldCell", bundle: nil), forCellReuseIdentifier: "EmailTextFieldCell")
//        self.tableView.register(UINib(nibName: "PasswordTextFieldCell", bundle: nil), forCellReuseIdentifier: "PasswordTextFieldCell")
//        self.tableView.register(UINib(nibName: "SpaceCell", bundle: nil), forCellReuseIdentifier: "SpaceCell")
//        self.tableView.register(UINib(nibName: "SigninTitleCell", bundle: nil), forCellReuseIdentifier: "SigninTitleCell")
//        self.tableView.register(UINib(nibName: "IconButtonCell", bundle: nil), forCellReuseIdentifier: "IconButtonCell")
//        self.tableView.register(UINib(nibName: "DividerCell", bundle: nil), forCellReuseIdentifier: "DividerCell")
//        self.tableView.register(UINib(nibName: "AnotherSigninCell", bundle: nil), forCellReuseIdentifier: "AnotherSigninCell")
        
        // 將上述簡化
        self.tableView.register(EmailTextFieldCell.self)
        self.tableView.register(PasswordTextFieldCell.self)
        self.tableView.register(SpaceCell.self)
        self.tableView.register(SigninTitleCell.self)
        self.tableView.register(IconButtonCell.self)
        self.tableView.register(DividerCell.self)
        self.tableView.register(AnotherSigninCell.self)
    }
}

// MARK: - NavigationBarDelegate
extension SigninViewController: NavigationBarDelegate {
    func didTapLeadingButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func didTapTrailingButton() {
        
    }
}

// MARK: - UITableViewDelegate
extension SigninViewController: UITableViewDelegate {
    
    /// height for header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    /// view for header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeKeyboard)))
        header.backgroundColor = .clear
        return header
    }
}

// MARK: - UITableViewDataSource
extension SigninViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(SigninTitleCell.self, for: indexPath)
            cell.baseDelegate = self
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(EmailTextFieldCell.self, for: indexPath)
            cell.roundTextField.textField.text = viewModel.email
            cell.baseDelegate = self
            cell.delegate = self
            self.emailTextFieldCell = cell
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(SpaceCell.self, for: indexPath)
            cell.setHeight(height: 16)
            cell.baseDelegate = self
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(PasswordTextFieldCell.self, for: indexPath)
            cell.roundSecretTextField.textField.text = viewModel.password
            cell.baseDelegate = self
            cell.delegate = self
            cell.setContent(placeholder: "Password", isShowTitle: true, title: "Recovery Password")
            self.passwordTextFieldCell = cell
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(SpaceCell.self, for: indexPath)
            cell.setHeight(height: 22)
            cell.baseDelegate = self
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(IconButtonCell.self, for: indexPath)
            cell.baseDelegate = self
            cell.delegate = self
            cell.setContent(title: "Sign in")
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(DividerCell.self, for: indexPath)
            return cell
        case 7:
            let cell = tableView.dequeueReusableCell(AnotherSigninCell.self, for: indexPath)
            cell.baseDelegate = self
            cell.delegate = self
            cell.setContent(.signin)
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
}

// MARK: - EmailTextFieldCellDelegate、PasswordTextFieldCellDelegate 共用
extension SigninViewController: EmailTextFieldCellDelegate {
    
    func textFieldShouldReturn(_ cell: UITableViewCell) {
//        if cell.isKind(of: EmailTextFieldCell.self) {
//            print("EmailTextFieldCell textFieldShouldReturn...")
//        } else if cell.isKind(of: PasswordTextFieldCell.self) {
//            print("PasswordTextFieldCell textFieldShouldReturn...")
//        }
    }
    
    func textFieldShouldBeginEditing(_ cell: UITableViewCell) {
//        if cell.isKind(of: EmailTextFieldCell.self) {
//            print("EmailTextFieldCell textFieldShouldBeginEditing...")
//        } else if cell.isKind(of: PasswordTextFieldCell.self) {
//            print("PasswordTextFieldCell textFieldShouldBeginEditing...")
//        }
    }
    
    func textFieldShouldEndEditing(_ cell: UITableViewCell) {
//        if cell.isKind(of: EmailTextFieldCell.self) {
//            print("EmailTextFieldCell textFieldShouldEndEditing...")
//            
//            let emailTextFieldCell = cell as! EmailTextFieldCell
//            if let text = emailTextFieldCell.roundTextField.textField.text {
//                self.viewModel.email = text
//            }
//            
//        } else if cell.isKind(of: PasswordTextFieldCell.self) {
//            print("PasswordTextFieldCell textFieldShouldEndEditing...")
//            
//            let passwordTextFieldCell = cell as! PasswordTextFieldCell
//            if let text = passwordTextFieldCell.roundSecretTextField.textField.text {
//                self.viewModel.password = text
//            }
//        }
    }
    
    func shouldChangeCharactersIn(_ cell: UITableViewCell, shouldChangeCharactersIn range: NSRange, replacementString string: String) {
//        if cell.isKind(of: EmailTextFieldCell.self) {
//            print("EmailTextFieldCell shouldChangeCharactersIn...")
//        } else if cell.isKind(of: PasswordTextFieldCell.self) {
//            print("PasswordTextFieldCell shouldChangeCharactersIn...")
//        }
    }
    
}

// MARK: - PasswordTextFieldCellDelegate
extension SigninViewController: PasswordTextFieldCellDelegate {
    func hintLabelTapped() {
        print("hintLabelTapped...")
    }
}

// MARK: - AnotherLoginCellDelegate
extension SigninViewController: AnotherSigninCellDelegate {
    func didTapGoogleAuth() {
        print("didTapGoogleAuth...")
    }
    
    func didTapAppleAuth() {
        print("didTapAppleAuth...")
    }
    
    func toAnotherViewController() {
        let viewController = SignupViewController()
        self.navigationController?.pushAndRemoveCurrentViewController(viewController)
    }
}

// MARK: - IconButtonCellDelegate
extension SigninViewController: IconButtonCellDelegate {
    func didTapIconButton() {
        // 關閉鍵盤
        self.activityIndicator.isHidden = false
        // 指定資料
        self.viewModel.email = emailTextFieldCell.roundTextField.textField.text ?? ""
        self.viewModel.password = passwordTextFieldCell.roundSecretTextField.textField.text ?? ""
        // 執行登入
        self.viewModel.signin()
    }
}

// MARK: - SigninViewModelDelegate
extension SigninViewController: SigninViewModelDelegate {
    func signinSuccessed() {
        self.activityIndicator.isHidden = true
        self.appDelegate.toHomeViewController()
    }
    
    func signinFailed(error: any Error) {
        self.activityIndicator.isHidden = true
        
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: - 所有的 Cell 都會繼承該 Delegate
extension SigninViewController: BaseCellDelegate {
    /// 額外可以填加 @objc，這樣就可以在該頁中給任何手勢 Selector 使用
    @objc func closeKeyboard() {
        self.view.endEditing(true)
    }
}
