//
//  toDoListTableTableViewController.swift
//  Todo
//
//  Created by Sarvad shetty on 12/25/17.
//  Copyright © 2017 Sarvad shetty. All rights reserved.
//

import UIKit
import RealmSwift

class toDoListTableTableViewController: UITableViewController{
    var itemArray: Results<Item>?
    let realm = try! Realm()
    var selectedCategory : Category? {
        
        didSet{
           loadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemArray?.count ?? 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoItemCell", for: indexPath)

        if  let item = itemArray?[indexPath.row]{
        cell.textLabel?.text = item.title

        cell.accessoryType = item.done == true ? .checkmark : .none
        }
        else{
            cell.textLabel?.text = "No items added"
        }

        return cell
    }
 
    //MARK: TableView Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = itemArray?[indexPath.row]{
            
            do{
                try realm.write {
                    item.done = !item.done
                    //to delete use this v
//                    realm.delete(item)
                }
            }
            catch{
                print("error while updating,\(error)")
            }
        }
   
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
   
    //MARK: IBActions
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert1 = UIAlertController(title: "Add Item?", message: "", preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "Add", style: .default) { (action) in
            if textField.text != ""{

                if let currentCategory = self.selectedCategory{
                    do{
                        try self.realm.write {
                            let newItem = Item()
                            newItem.title = textField.text!
                            currentCategory.item.append(newItem)
                        }
                    }
                    catch{
                        print("error while saving..,\(error)")
                    }
                }
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
    
    //MARK: Model manipulation

    func loadData(){

            itemArray = selectedCategory?.item.sorted(byKeyPath: "title", ascending: true)
          tableView.reloadData()
    }
    
}

//extension toDoListTableTableViewController : UISearchBarDelegate {
//    //MARK: UISearchBar Delegate function
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//        request.predicate = predicate
//        //now to sort using sort descriptor
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//        //now to fetch the data
//        loadData(with: request,with: predicate )
//
//    }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text?.count == 0
//        {
//            loadData()
//
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder()
//            }
//        }
//        //now to use resign first responder faster we put it in the main thread by following command p.s. we use async to make it asynchronous
//
//    }
//
//}

