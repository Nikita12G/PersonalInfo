//
//  PersonTableViewCell.swift
//  PersonalInfo
//
//  Created by Никита Гуляев on 29.11.2021.
//

import UIKit

class PersonTableViewCell: UITableViewCell {

    private var person = Person.getPerson()
    var personViewController = PersonViewController()
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func deleteButton(_ sender: Any) {
        person.removeLast()
        personViewController.personInfoTabel.reloadData()
    }
    
}
