//
//  PersonTableViewCell.swift
//  PersonalInfo
//
//  Created by Никита Гуляев on 29.11.2021.
//

import UIKit

class PersonTableViewCell: UITableViewCell {
    
    var personViewController = PersonViewController()
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameTextField.returnKeyType = .next
        nameTextField.delegate = self
    }
}

//    MARK: - UITextField Delegate

extension PersonTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = nameTextField.superview?.viewWithTag(nameTextField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            nameTextField.resignFirstResponder()
            return true
        }
        return false
    }
}

