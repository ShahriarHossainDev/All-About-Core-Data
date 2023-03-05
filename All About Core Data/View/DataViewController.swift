//
//  DataViewController.swift
//  All About Core Data
//
//  Created by Shishir_Mac on 5/3/23.
//

import UIKit
import CoreData

class DataViewController: UIViewController {
    @IBOutlet weak var dataTableView: UITableView!
    
    // Reference NS Managed Object Context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // Data table
    var items: [Person]?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataTableView.dataSource = self
        dataTableView.delegate = self

        // Do any additional setup after loading the view.
    }

}

// MARK: - TableView  UITableViewDelegate, UITableViewDataSource
extension DataViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
