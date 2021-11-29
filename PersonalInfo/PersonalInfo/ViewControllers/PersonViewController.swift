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
    
    @IBOutlet weak var personInfoTabel: UITableView!
    
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
        personInfoTabel.reloadData()
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
    
    private func AddChilde() {
        person.append(.init(name: "", age: ""))
        personInfoTabel.reloadData()
        
        if person.count > 5 {
            addChildButton.isHidden = true
        }
        
    }
}
    


