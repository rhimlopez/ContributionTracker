//
//  ViewController.swift
//  Contribution Tracker
//
//  Created by Annie on 2021-02-26.
// Test

import UIKit
import RealmSwift

class AccountsViewController: UITableViewController {
    
    let realm = try! Realm()

    var accountArray : Results<Account>?
    
    let dataFilePath2 = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataFilePath2)
        
        loadAccounts()
        
        tableView.separatorStyle = .none
        
        tableView.rowHeight = 80.0
        
 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        guard let navBar = navigationController?.navigationBar else {fatalError("Navigation controller does not exist.")}
        
        navBar.backgroundColor = UIColor(named: "1D9BF6")
        
    }
    
    
    // MARK: - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let account = accountArray?[indexPath.row] {
            
            cell.textLabel?.text = account.name
            
//            guard let accountColour = UIColor(hexString: account.colour) else {fatalError()}
//
//            cell.backgroundColor = accountColour
//
//            cell.textLabel?.textColor = ContrastColorOf(categoryColour, returnFlat: true)
        }
        
        return cell
    }
    
    func loadAccounts() {
        
        
    }
    
    //MARK: - TableView Delegate Methods
    // What happens when you click on one of hte cells
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToSettings", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! SettingsViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedAccount = accountArray?[indexPath.row]
        }
    }
    
    // MARK: -  Add new items
    
    @IBAction func addButtonPressed2(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Account", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Account", style: .default) { (action) in
            // What happens when add account button tapped
            
            
            let newAccount = Account()
            newAccount.name = textField.text!
            self.save(account:newAccount)
        
        }
        
        alert.addAction(action)
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add new account"
            
            
        }
        
        present(alert, animated: true, completion: nil)

}

    //MARK: - Data Manipulation Methods
    // Save data and load data
    func save(account:Account) {
        do {
            try realm.write {
                realm.add(account)
            }
        } catch {
            print("Error saving context \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategories() {
        
        accountArray = realm.objects(Account.self)
        
        tableView.reloadData()
        
    }
    
    //MARK: - Delete Data from Swipe
    
//    override func updateModel(at indexPath: IndexPath) {
//            if let categoryForDeletion = self.accountArray?[indexPath.row]{
//            do {
//                try self.realm.write {
//                    self.realm.delete(categoryForDeletion)
//                }
//            } catch {
//                print("Error deleting category, \(error)")
//            }
//        }
//    }

    
    
}
