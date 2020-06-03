//
//  UserInforInputTableViewCell.swift
//  PayTabsClient
//
//  Created by Mohamed Adly on 6/3/20.
//  Copyright © 2020 Mohamed Adly. All rights reserved.
//

import UIKit

class UserInforInputTableViewCell: UITableViewCell {

    @IBOutlet weak var inputTitleLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    var onTextChanged: ((_ text: String) -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}

extension UserInforInputTableViewCell: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let previousText:NSString = textField.text! as NSString
        let finalText = previousText.replacingCharacters(in: range, with: string)
        if let onTextChanged = onTextChanged {
            onTextChanged(finalText)
        }
        return true
    }
}
