//
//  toDoListTableTableViewController.swift
//  Todo
//
//  Created by Sarvad shetty on 12/25/17.
//  Copyright © 2017 Sarvad shetty. All rights reserved.
//

import UIKit

class toDoListTableTableViewController: UITableViewController {
    
    
    var itemArray = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let newitem = Item()
        newitem.title = "hi"
        itemArray.append(newitem)
      
        
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item]{
//            itemArray = items
//            }
        loadData()
        
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
//        cell.textLabel?.text = itemArray[indexPath.row].title
//        if itemArray[indexPath.row].done == true {
//            cell.accessoryType = .checkmark
//        }
//        else{
//            cell.accessoryType = .none
//        }
        //instead of using this ^ we can also use this v
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        }
//        else{
//            cell.accessoryType = .none
//        }
        
        //u could do this ^ or do using ternary statement ?:
        cell.accessoryType = item.done == true ? .checkmark : .none
//        saveData()
        return cell
    }
 
    //MARK: TableView Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        }
//        else{
//            itemArray[indexPath.row].done = false
//        }
        //u could do this^ or this v
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
   
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert1 = UIAlertController(title: "Add Item?", message: "", preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "Add item", style: .default) { (action) in
            if textField.text != ""{
                let newItem = Item()
                
                newItem.title = textField.text!
                
                self.itemArray.append(newItem)
                
                   self.saveData()
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
    
    //MARK: functions
    func saveData(){
        
           let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to:dataFilePath!)
        }
        catch{
            print("error encoding item array, \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadData(){
        if let data1 = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
                itemArray = try decoder.decode([Item].self, from: data1)
            }
            catch{
                print("error while decoding ,\(error)")
            }
        }
    }
    
}
