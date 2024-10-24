//
//  IconButtonCell.swift
//  SpotifyDemo
//
//  Created by Ling Zhan on 2024/9/11.
//

import UIKit

protocol IconButtonCellDelegate: AnyObject {
    func didTapIconButton()
}

class IconButtonCell: BaseCell {

    @IBOutlet weak var button: UIButton!
    
    weak var delegate: IconButtonCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.configure()
    }
    
    func configure() {
        self.button.layer.cornerRadius = 30
        self.button.layer.masksToBounds = true
        
    }
    
    func setContent(title: String) {
        self.button.setTitle(title, for: .normal)
    }
    
    @IBAction func didTapButton(_ sender: Any) {
        self.delegate?.didTapIconButton()
    }
    
}
