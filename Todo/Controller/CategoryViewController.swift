//
//  CategoryViewController.swift
//  Todo
//
//  Created by Sarvad shetty on 12/30/17.
//  Copyright © 2017 Sarvad shetty. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController{
    
    
    
    let realm = try! Realm()
    
    var categoryArray : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
          //print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        load()
        //tableView.rowHeight = 80.0
        
        tableView.separatorStyle = .none
    }
    
    
    
    //MARK: Tableview Datasource methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categoryArray?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No categories added yet"
        let clr = UIColor(hexString: categoryArray?[indexPath.row].color ?? "C6D6FF")
        cell.backgroundColor = clr
        cell.textLabel?.textColor = ContrastColorOf(clr!, returnFlat: true)
        return cell
    }
    
    
    
    
    //MARK: Tableview Delgate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    
    
    //MARK: Prepare segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! toDoListTableTableViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray?[indexPath.row]
        }
    }

    
    
    
    
    //MARK: IBActions
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert1 = UIAlertController(title: "Add new item?", message: "", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Add", style: .default) { (action) in
            if textField.text != ""{
                
                let newItem = Category()
                newItem.name = textField.text!
                newItem.color = UIColor.randomFlat.hexValue()
                self.save(category: newItem)
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
            alertTextField.placeholder = "create item"
            textField = alertTextField
        }
        present(alert1, animated: true, completion: nil)
    }
    
    
    
    
    
    //MARK: Datamodel manipulation
    
    
    func save(category: Category){
        do{
            try realm.write {
                realm.add(category)
            }
        }
        catch{
            print("error while saving,\(error)")
        }
        tableView.reloadData()
    }
    
    func load(){
        categoryArray = realm.objects(Category.self)
        tableView.reloadData()
}
    
    
    override func updateModel(at indexPath: IndexPath) {
        if let categorySelected = categoryArray?[indexPath.row]{
            do{
                try realm.write {
                    realm.delete(categorySelected)
                }
            }catch{
                print("error while deleting,\(error)")
            }
        }
    }
}


