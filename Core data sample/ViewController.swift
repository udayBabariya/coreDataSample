//
//  ViewController.swift
//  Core data sample
//
//  Created by uday on 8/17/17.
//  Copyright © 2017 uday. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var people = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        do{
            let people = try PersistanceService.context.fetch(fetchRequest)
            self.people = people
            self.tableView.reloadData()
        }catch{
            print(error)}
    }

    @IBAction func onPlusTapped() {
        let alert = UIAlertController(title: "Add Person", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "name"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Age"
            textField.keyboardType = .numberPad
        }
        let action = UIAlertAction(title: "Post", style: .default) { (_) in
            let name = alert.textFields!.first!.text!
            let age = alert.textFields!.last!.text!
            let person = Person(context: PersistanceService.context)
            person.name = name
            person.age = Int16(age)!
            PersistanceService.saveContext()
            self.people.append(person)
            self.tableView.reloadData()
            
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = people[indexPath.row].name
        cell.detailTextLabel?.text = String(people[indexPath.row].age)
        return cell
        
    }
}

