//
//  ViewController.swift
//  PersonalInfo
//
//  Created by Никита Гуляев on 25.11.2021.
//

import UIKit

class PersonViewController: UIViewController {
    
    private var person = Person.getPerson()
    var personTableViewCell = PersonTableViewCell()
    
    @IBOutlet weak var personInfoTable: UITableView!
    
    @IBOutlet weak var addChildButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Персональные данные"
        
    }
    
    @IBAction func addChild(_ sender: Any) {
        AddChilde()
    }
    
    @IBAction func clear(_ sender: Any) {
        person.removeAll()
        addChildButton.isHidden = false
        personInfoTable.reloadData()
    }
    
    private func AddChilde() {
        
        person.append(.init(name: "", age: ""))
        personInfoTable.reloadData()
        
        if person.count == 5 {
            addChildButton.isHidden = true
            
        }
    }
}

extension PersonViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        person.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PersonTableViewCell
        
        return cell
    }
    
    
    
}
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
}

