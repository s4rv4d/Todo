//
//  toDoListTableTableViewController.swift
//  Todo
//
//  Created by Sarvad shetty on 12/25/17.
//  Copyright © 2017 Sarvad shetty. All rights reserved.
//

import UIKit

class toDoListTableTableViewController: UITableViewController {
    
    
    var itemArray = ["get knowledge on development","eat food","drink cofee"]
    let defaults = UserDefaults.standard
    

    override func viewDidLoad() {
        super.viewDidLoad()

        if let items = defaults.array(forKey: "TodoListArray") as? [String]{
            itemArray = items
        }
    }



    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoItemCell", for: indexPath)
        // Configure the cell...
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
 
    //MARK: TableView Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
           if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark
           {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
           else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
   
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert1 = UIAlertController(title: "Add Item?", message: "", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Add item", style: .default) { (action) in
            if textField.text != ""{
            self.itemArray.append(textField.text!)
                self.defaults.set(self.itemArray, forKey: "TodoListArray")
                self.tableView.reloadData()
            }
            else{
                let alert2 = UIAlertController(title: "enter something u noob", message: "", preferredStyle: .alert)
                let action2 = UIAlertAction(title: "retry", style: .default, handler: { (actionlol) in
                    self.present(alert1, animated: true, completion: nil)
                })
                alert2.addAction(action2)
                self.present(alert2, animated: true, completion: nil)
            }
        }
        alert1.addAction(action1)
        alert1.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create item"
            textField = alertTextField
        }
        present(alert1, animated: true, completion: nil)
    }
    
}
