//
//  DataViewController.swift
//  All About Core Data
//
//  Created by Shishir_Mac on 5/3/23.
//

import UIKit
import CoreData

class DataViewController: UIViewController {
    
    private let cellIdentifier: String = "cell"
    
    @IBOutlet weak var dataTableView: UITableView!
    @IBOutlet weak var nameSearchBar: UISearchBar!
    
    // Reference NS Managed Object Context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // Data table
    var items: [Person]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataTableView.dataSource = self
        dataTableView.delegate = self
        dataTableView.separatorStyle = .none
        
        fetchPeople()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Function
    
    // 2 data Tabel Relation Ship 
    func fetchRelationShip() {
        let family = Family(context: context)
        family.name = "Hossain"
        
        let person = Person(context: context)
        person.name = "Atik"
        
        family.addToPeople(person)
        
        //
        try! context.save()
    }
    
    func fetchPeople() {
        do {
            
            let request = Person.fetchRequest() as NSFetchRequest<Person>
            let nameSearch = nameSearchBar.text
            
            if nameSearch == "" {
                //Sorting
                let sort = NSSortDescriptor(key: "name", ascending: true)
                request.sortDescriptors = [sort]
                
                self.items = try context.fetch(request)
                
                DispatchQueue.main.async {
                    self.dataTableView.reloadData()
                }
            } else {
                // Filtering
                let pred = NSPredicate(format: "name CONTAINS '%@'", nameSearch!)
                request.predicate = pred
                
                self.items = try context.fetch(request)
                
                DispatchQueue.main.async {
                    self.dataTableView.reloadData()
                }
            }
            
        } catch {
            print("Error")
        }
        
    }
    
    
    
    @IBAction func addButtonAction(_ sender: UIBarButtonItem) {
        
        let actionController = UIAlertController(title: "Add New Person", message : "Enter Person Info...!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Add", style: .default, handler: { (action) -> Void in
            if actionController.textFields![0].text == "" {
                print("Enter Name")    // You refuse OK
            } else {
                print("OK")     // Do whatever you need: update tableView
            }
            if actionController.textFields![1].text == "" {
                print("Enter Gender")     // You refuse OK
            } else {
                let newPerson = Person(context: self.context)
                newPerson.name = actionController.textFields![0].text
                newPerson.gender = actionController.textFields![1].text
                newPerson.age = Int16(actionController.textFields![2].text!) ?? 24
                
                // Save Data
                
                do {
                    try self.context.save()
                } catch {
                    
                }
                
                // Re-fetch data
                self.fetchPeople()  // Do whatever you need:  update tableView
            }
            
        } )
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        actionController.addAction(okAction)
        actionController.addAction(cancelAction)
        
        
        actionController.addTextField { textField -> Void in
            textField.placeholder = "Enter Name..."
        }
        
        actionController.addTextField { textField -> Void in
            textField.placeholder = "Enter Gender..."
        }
        
        actionController.addTextField { textField -> Void in
            textField.placeholder = "Enter Age..."
        }
        
        self.present(actionController, animated: true, completion: nil)
    }
    
    
}

// MARK: - TableView  UITableViewDelegate, UITableViewDataSource
extension DataViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? DataTableViewCell {
            cell.configurateTheCell(items![indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person = self.items![indexPath.row]
        
        let actionController = UIAlertController(title: "Edit Person", message : "Enter Person Info...!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Save", style: .default, handler: { (action) -> Void in
            if actionController.textFields![0].text == "" {
                print("Enter Name")    // You refuse OK
            } else {
                print("OK")     // Do whatever you need: update tableView
            }
            if actionController.textFields![1].text == "" {
                print("Enter Gender")     // You refuse OK
            } else {
                //let newPerson = Person(context: self.context)
                person.name = actionController.textFields![0].text
                person.gender = actionController.textFields![1].text
                person.age = Int16(actionController.textFields![2].text!) ?? 24
                
                // Save Data
                
                do {
                    try self.context.save()
                } catch {
                    
                }
                
                // Re-fetch data
                self.fetchPeople()  // Do whatever you need:  update tableView
            }
            
        } )
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        actionController.addAction(okAction)
        actionController.addAction(cancelAction)
        
        actionController.addTextField { textField -> Void in
            textField.text = person.name
        }
        
        actionController.addTextField { textField -> Void in
            textField.text = person.gender
        }
        
        actionController.addTextField { textField -> Void in
            textField.text = "\(person.age)"
        }
        
        self.present(actionController, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // Swipe action
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            //Object
            let personTORemove = self.items![indexPath.row]
            
            // Delete
            self.context.delete(personTORemove)
            
            // Save Data
            do {
                try self.context.save()
            } catch {
                
            }
            
            self.fetchPeople()
            
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
}
