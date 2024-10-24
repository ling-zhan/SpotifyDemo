//
//  EmailTextFieldCell.swift
//  SpotifyDemo
//
//  Created by Ling Zhan on 2024/9/11.
//

import UIKit

protocol EmailTextFieldCellDelegate: NSObject {
    func textFieldShouldReturn(_ cell: UITableViewCell)
    func textFieldShouldBeginEditing(_ cell: UITableViewCell)
    func textFieldShouldEndEditing(_ cell: UITableViewCell)
    func shouldChangeCharactersIn(_ cell: UITableViewCell, shouldChangeCharactersIn range: NSRange, replacementString string: String)
}

class EmailTextFieldCell: BaseCell {
    
    @IBOutlet weak var roundTextField: RoundTextField!
    
    weak var delegate: EmailTextFieldCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.configure()
    }

    func configure() {
        roundTextField.textField.delegate = self
    }
    
    func setContent(placeholder: String) {
        roundTextField.textField.placeholder = placeholder
    }
    
}

// MARK: - UITextFieldDelegate
// 這裡如果不好用的話，那麼就直接寫在 ViewController 裡面即可
extension EmailTextFieldCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // resignFirstResponder: 關閉鍵盤
        textField.resignFirstResponder()
        delegate?.textFieldShouldReturn(self)
        return true
    }
    
    // textFieldShouldBeginEditing: 開始編輯時
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        delegate?.textFieldShouldBeginEditing(self)
        return true
    }
    
    // textFieldShouldEndEditing: 結束編輯時
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        delegate?.textFieldShouldEndEditing(self)
        return true
    }
    
    // shouldChangeCharactersIn: 改變文字時
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        delegate?.shouldChangeCharactersIn(self,shouldChangeCharactersIn: range, replacementString: string)
        return true
    }

}
