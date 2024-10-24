//
//  SignupViewController.swift
//  SpotifyDemo
//
//  Created by Ling Zhan on 2024/9/10.
//

import UIKit

class SignupViewController: BaseViewController {
    
    @IBOutlet weak var navigationBar: NavigationBar!
    @IBOutlet weak var navigationBarTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let viewModel: SignupViewModel = .init()
    
    /* 因為要取得 cell 裡面 textfield 輸入的內容，所以要宣告 cell 變數，隨後再指定 */
    var fullNameTextFieldCell: FullNameTextFieldCell = .init()
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
//        self.tableView.register(UINib(nibName: "RegisterTitleCell", bundle: nil), forCellReuseIdentifier: "RegisterTitleCell")
//        self.tableView.register(UINib(nibName: "FullNameTextFieldCell", bundle: nil), forCellReuseIdentifier: "FullNameTextFieldCell")
//        self.tableView.register(UINib(nibName: "EmailTextFieldCell", bundle: nil), forCellReuseIdentifier: "EmailTextFieldCell")
//        self.tableView.register(UINib(nibName: "PasswordTextFieldCell", bundle: nil), forCellReuseIdentifier: "PasswordTextFieldCell")
//        self.tableView.register(UINib(nibName: "SpaceCell", bundle: nil), forCellReuseIdentifier: "SpaceCell")
//        self.tableView.register(UINib(nibName: "IconButtonCell", bundle: nil), forCellReuseIdentifier: "IconButtonCell")
//        self.tableView.register(UINib(nibName: "DividerCell", bundle: nil), forCellReuseIdentifier: "DividerCell")
//        self.tableView.register(UINib(nibName: "AnotherSigninCell", bundle: nil), forCellReuseIdentifier: "AnotherSigninCell")
        
        // 將上述簡化
        self.tableView.register(RegisterTitleCell.self)
        self.tableView.register(FullNameTextFieldCell.self)
        self.tableView.register(EmailTextFieldCell.self)
        self.tableView.register(PasswordTextFieldCell.self)
        self.tableView.register(SpaceCell.self)
        self.tableView.register(IconButtonCell.self)
        self.tableView.register(DividerCell.self)
        self.tableView.register(AnotherSigninCell.self)
        
    }
}

// MARK: - NavigationBarDelegate
extension SignupViewController: NavigationBarDelegate {
    func didTapLeadingButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func didTapTrailingButton() {
        
    }

}

// MARK: - UITableViewDelegate
extension SignupViewController: UITableViewDelegate {
    
    // height for header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    // view for header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = .clear
        return header
    }
}

// MARK: - UITableViewDataSource
extension SignupViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(RegisterTitleCell.self, for: indexPath)
            cell.baseDelegate = self
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(FullNameTextFieldCell.self, for: indexPath)
            cell.baseDelegate = self
            cell.delegate = self
            cell.setContent(placeholder: "Full Name")
            self.fullNameTextFieldCell = cell
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(SpaceCell.self, for: indexPath)
            cell.setHeight(height: 16)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(EmailTextFieldCell.self, for: indexPath)
            cell.baseDelegate = self
            cell.delegate = self
            cell.setContent(placeholder: "Email")
            self.emailTextFieldCell = cell
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(SpaceCell.self, for: indexPath)
            cell.baseDelegate = self
            cell.setHeight(height: 16)
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(PasswordTextFieldCell.self, for: indexPath)
            cell.baseDelegate = self
            cell.setContent(placeholder: "Password", isShowTitle: false)
            self.passwordTextFieldCell = cell
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(SpaceCell.self, for: indexPath)
            cell.baseDelegate = self
            cell.setHeight(height: 33)
            return cell
        case 7:
            let cell = tableView.dequeueReusableCell(IconButtonCell.self, for: indexPath)
            cell.baseDelegate = self
            cell.delegate = self
            cell.setContent(title: "Create Account")
            return cell
        case 8:
            let cell = tableView.dequeueReusableCell(DividerCell.self, for: indexPath)
            return cell
        case 9:
            let cell = tableView.dequeueReusableCell(AnotherSigninCell.self, for: indexPath)
            cell.baseDelegate = self
            cell.delegate = self
            cell.setContent(.register)
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
}

// MARK: - TextFieldCellDelegate 共用
// FullNameTextFieldCellDelegate
// EmailTextFieldCellDelegate
// PasswordTextFieldCellDelegate
extension SignupViewController: EmailTextFieldCellDelegate, FullNameTextFieldCellDelegate {
    
    func textFieldShouldReturn(_ cell: UITableViewCell) {
//        if cell.isKind(of: FullNameTextFieldCell.self) {
//            print("FullNameTextFieldCell textFieldShouldReturn...")
//        } else if cell.isKind(of: EmailTextFieldCell.self) {
//            print("EmailTextFieldCell textFieldShouldReturn...")
//        } else if cell.isKind(of: PasswordTextFieldCell.self) {
//            print("PasswordTextFieldCell textFieldShouldReturn...")
//        }
    }
    
    func textFieldShouldBeginEditing(_ cell: UITableViewCell) {
//        if cell.isKind(of: FullNameTextFieldCell.self) {
//            print("FullNameTextFieldCell textFieldShouldBeginEditing...")
//        } else if cell.isKind(of: EmailTextFieldCell.self) {
//            print("EmailTextFieldCell textFieldShouldBeginEditing...")
//        } else if cell.isKind(of: PasswordTextFieldCell.self) {
//            print("PasswordTextFieldCell textFieldShouldBeginEditing...")
//        }
    }
    
    func textFieldShouldEndEditing(_ cell: UITableViewCell) {
//        if cell.isKind(of: FullNameTextFieldCell.self) {
//            print("FullNameTextFieldCell textFieldShouldEndEditing...")
//        } else if cell.isKind(of: EmailTextFieldCell.self) {
//            print("EmailTextFieldCell textFieldShouldEndEditing...")
//        } else if cell.isKind(of: PasswordTextFieldCell.self) {
//            print("PasswordTextFieldCell textFieldShouldEndEditing...")
//        }
    }
    
    func shouldChangeCharactersIn(_ cell: UITableViewCell, shouldChangeCharactersIn range: NSRange, replacementString string: String) {
//        if cell.isKind(of: FullNameTextFieldCell.self) {
//            print("FullNameTextFieldCell shouldChangeCharactersIn...")
//        } else if cell.isKind(of: EmailTextFieldCell.self) {
//            print("EmailTextFieldCell shouldChangeCharactersIn...")
//        } else if cell.isKind(of: PasswordTextFieldCell.self) {
//            print("PasswordTextFieldCell shouldChangeCharactersIn...")
//        }
    }
    

}

extension SignupViewController: AnotherSigninCellDelegate {
    func didTapGoogleAuth() {
        print("didTapGoogleAuth...")
    }
    
    func didTapAppleAuth() {
        print("didTapAppleAuth...")
    }
    
    func toAnotherViewController() {
        let viewController = SigninViewController()
        self.navigationController?.pushAndRemoveCurrentViewController(viewController)
    }
}

extension SignupViewController: IconButtonCellDelegate {
    func didTapIconButton() {
        
        self.activityIndicator.isHidden = false
        
//        self.viewModel.fullName = self.fullNameTextFieldCell.roundTextField.textField.text ?? ""
//        self.viewModel.email = self.emailTextFieldCell.roundTextField.textField.text ?? ""
//        self.viewModel.password = self.passwordTextFieldCell.roundSecretTextField.textField.text ?? ""
        
        self.viewModel.register()
    }
}

extension SignupViewController: SignupViewModelDelegate {
    func registerSuccessed() {
        self.activityIndicator.isHidden = true
        self.appDelegate.toHomeViewController()
    }
    
    func registerFailed(error: Error) {
        self.activityIndicator.isHidden = true
        
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: - 所有的 Cell 都會繼承該 Delegate
extension SignupViewController: BaseCellDelegate {
    /// 額外可以填加 @objc，這樣就可以在該頁中給任何手勢 Selector 使用
    @objc func closeKeyboard() {
        self.view.endEditing(true)
    }
}
