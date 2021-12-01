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
    @IBAction func deleteButton(_ sender: Any) {

    }
    
}

