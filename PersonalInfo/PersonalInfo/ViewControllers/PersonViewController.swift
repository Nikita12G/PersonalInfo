//
//  ViewController.swift
//  PersonalInfo
//
//  Created by Никита Гуляев on 25.11.2021.
//

import UIKit

class PersonViewController: UIViewController {
    
    private var person = Person.getPerson()
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var personInfoTable: UITableView!
    @IBOutlet weak var addChildButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Персональные данные"
        registerForKeyboardNotifications()
        nameTextField.returnKeyType = .next
        ageTextField.returnKeyType = .go
        nameTextField.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    deinit {
        removeKeyboardNotification()
    }
    
    @IBAction func addChild(_ sender: Any) {
        addChilde()
    }
    
    @IBAction func clear(_ sender: Any) {
        showAlert()
    }
    
    //    MARK: - Private methods
    
    private func addChilde() {
        person.append(.init(name: "", age: ""))
        personInfoTable.reloadData()
        
        if person.count == 5 {
            addChildButton.isHidden = true
            
        }
    }
    
    private func clear () {
        person.removeAll()
        addChildButton.isHidden = false
        nameTextField.text = ""
        ageTextField.text = ""
        personInfoTable.reloadData()
    }
    
    private func showAlert() {
        let alert = UIAlertController(
            title: "Сбросить данные",
            message: "Вы уверены что хотите сбросить данные?",
            preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(
            title: "Сбросить данные",
            style: .destructive,
            handler: { action in self.clear()
            }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .default, handler: { action in
        }))
        present(alert, animated: true)
    }
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func removeKeyboardNotification () {
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func kbWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo
        let kbFromSize = (userInfo?[PersonViewController.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        personInfoTable.contentOffset = CGPoint(x: 0, y: kbFromSize.height)
    }
    
    @objc func kbWillHide () {
        personInfoTable.contentOffset = CGPoint.zero
    }
    
    @objc func deleteRow(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: personInfoTable)
        guard let indexPath = personInfoTable.indexPathForRow(at: point) else {
            return
        }
        person.remove(at: indexPath.row)
        personInfoTable.deleteRows(at: [indexPath], with: .left)
        if person.count < 5 {
            addChildButton.isHidden = false
        }
    }
}
//    MARK: - UITableView Data Source

extension PersonViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        person.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PersonTableViewCell
        
        if let deleteButton = cell.contentView.viewWithTag(102) as? UIButton {
            deleteButton.addTarget(self, action: #selector(deleteRow(_ :)), for: .touchUpInside)
        }
        
        return cell
    }
}

//    MARK: - UITableView Delegate

extension PersonViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            personInfoTable.beginUpdates()
            person.remove(at: indexPath.row)
            personInfoTable.deleteRows(at: [indexPath], with: .fade)
            personInfoTable.endUpdates()
            
            if person.count < 5 {
                addChildButton.isHidden = false
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if personInfoTable.isDecelerating {
            view.endEditing(true)
        }
    }
}

//    MARK: - UITextField Delegate

extension PersonViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = nameTextField.superview?.viewWithTag(nameTextField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            nameTextField.resignFirstResponder()
            return true
        }
        return false
    }
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if (indexPath.section == 0) {return nil}
        if ( indexPath.row <= 2 ) {return nil}
        return indexPath
    }
    
}

