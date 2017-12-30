//
//  CategoryViewController.swift
//  Todo
//
//  Created by Sarvad shetty on 12/30/17.
//  Copyright © 2017 Sarvad shetty. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categoryArray = [Category]()
    
    let context2 = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
          print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        load()
    }
    //MARK: Tableview Datasource methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categoryArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categoryArray[indexPath.row].name
        return cell
    }

    //MARK: IBActions
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert1 = UIAlertController(title: "Add new item?", message: "", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Add", style: .default) { (action) in
            if textField.text != ""{
                
                let newItem = Category(context: self.context2)
                newItem.name = textField.text
                self.categoryArray.append(newItem)
                self.save()
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
    
    
    func save(){
        do{
            try context2.save()
        }
        catch{
            print("error while saving,\(error)")
        }
        tableView.reloadData()
    }
    
    func load(){
        let request:NSFetchRequest<Category> = Category.fetchRequest()
        do{
        categoryArray = try context2.fetch(request) //the value of fetch request is always an array
        }
        catch{
            print("error while fetching, \(error)")
        }
        tableView.reloadData()
    }
    
}
