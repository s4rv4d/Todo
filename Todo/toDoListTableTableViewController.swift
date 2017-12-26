//
//  toDoListTableTableViewController.swift
//  Todo
//
//  Created by Sarvad shetty on 12/25/17.
//  Copyright © 2017 Sarvad shetty. All rights reserved.
//

import UIKit

class toDoListTableTableViewController: UITableViewController {
    
    
    let itemArray = ["get knowledge on development","eat food","drink cofee"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
   

}
