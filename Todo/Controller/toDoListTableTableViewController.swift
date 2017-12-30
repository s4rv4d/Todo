//
//  toDoListTableTableViewController.swift
//  Todo
//
//  Created by Sarvad shetty on 12/25/17.
//  Copyright © 2017 Sarvad shetty. All rights reserved.
//

import UIKit
import CoreData

class toDoListTableTableViewController: UITableViewController{
    var itemArray = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
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

        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title

        cell.accessoryType = item.done == true ? .checkmark : .none

        return cell
    }
 
    //MARK: TableView Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
   
    //MARK: IBActions
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert1 = UIAlertController(title: "Add Item?", message: "", preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "Add item", style: .default) { (action) in
            if textField.text != ""{
               
                let newItem = Item(context: self.context)
                
                newItem.title = textField.text!
                newItem.done = false
                
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
    
    //MARK: Model manipulation
    func saveData(){
        
        do{
           try context.save()
        }
        catch{
            print("error saving context , \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadData(with request:NSFetchRequest<Item> = Item.fetchRequest()){
        do{
            itemArray = try context.fetch(request)
        }
        catch{
            print("error while fetching data from context ,\(error)")
        }
          tableView.reloadData()
    }
    
}

extension toDoListTableTableViewController : UISearchBarDelegate {
    //MARK: UISearchBar Delegate function
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        //now to sort using sort descriptor
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        //now to fetch the data
        loadData(with: request)
      
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0
        {
            loadData()
          
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
        //now to use resign first responder faster we put it in the main thread by following command p.s. we use async to make it asynchronous
     
    }

}
