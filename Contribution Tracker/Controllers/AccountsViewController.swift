//
//  ViewController.swift
//  Contribution Tracker
//
//  Created by Annie on 2021-02-26.
//

import UIKit
import RealmSwift

class AccountsViewController: UITableViewController {

    var itemArray = [Account]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let newAccount = Account()
        newAccount.name = "1"
        itemArray.append(newAccount)

        let newAccount2 = Account()
        newAccount2.name = "2"
        itemArray.append(newAccount2)

        let newAccount3 = Account()
        newAccount3.name = "3"
        itemArray.append(newAccount3)
    }
    
    
    // MARK - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContributedAmountCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row].name
        
        return cell
    }
    
    // MARK -  Add new items
    
    @IBAction func addButtonPressed2(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Account", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Account", style: .default) { (action) in
            // What happens when add account button tapped
            
            
            let newAccount = Account()
            newAccount.name = textField.text!
            
            self.itemArray.append(newAccount)
            
            self.tableView.reloadData()
        
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter account name"
            textField = alertTextField
            
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    

}

