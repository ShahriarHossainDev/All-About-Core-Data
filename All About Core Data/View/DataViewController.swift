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
    
    func fetchPeople() {
        do {
            self.items = try context.fetch(Person.fetchRequest())
            
            DispatchQueue.main.async {
                self.dataTableView.reloadData()
            }
        } catch {
            print("Error")
        }
        
    }
    
    
    @IBAction func addButtonAction(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "Add New Person", message: "Enter Person Info...!", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Add", style: .default) { (_) in
            if let txtField = alertController.textFields?.first, let text = txtField.text {
                // operations
                
                // Create Object
                let newPerson = Person(context: self.context)
                newPerson.name = text
                newPerson.gender = "Male"
                newPerson.age = 24
                
                // Save Data
                
                do {
                    try self.context.save()
                } catch {

                }
                
                
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Person Name"
        }
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
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
        
        let alertController = UIAlertController(title: "Edit Person", message: "Edit Person Info...!", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Add", style: .default) { (_) in
            if let txtField = alertController.textFields?.first, let text = txtField.text {
                
                // operations
                print("Text==>" + text)
            }
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        alertController.addTextField { (textField) in
            textField.text = person.name
        }
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
}
