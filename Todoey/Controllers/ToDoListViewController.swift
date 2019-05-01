//
//  ViewController.swift
//  Todoey
//
//  Created by Jiyoung on 29/04/2019.
//  Copyright © 2019 Jiyoung Kim. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    
    var itemArray = [Items]() /*In an array because it has two objects*/
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let newItem = Items()
        newItem.title = "1st todo item"
        itemArray.append(newItem)
        
        let newItem2 = Items()
        newItem2.title = "2nd todo item"
        itemArray.append(newItem2)
        
        /*Setting the itemArray with the data stored in SQLite*/
        if let items = defaults.array(forKey: "TodoListArray") as? [Items] {
            itemArray = items
        }
        
    }
    
    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /*Making the cells of tableview reusable cells*/
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        /*setting the text of 'textLabel' of a cell in the key 'title' in the itemArray*/
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        
        /*ternary Operator*/
        let item = itemArray[indexPath.row]
        cell.accessoryType = item.done ? .checkmark : .none
        
//        if itemArray[indexPath.row].done != true {
//            cell.accessoryType = .none
//        } else {
//            cell.accessoryType = .checkmark
//
//        }
        
        tableView.reloadData() /*To trigger the tableView didSelectRowAt everytime there is an action going and reloads the checkmark symbol*/
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done //setting the done property opposite to the current one
        
        /*Animating when it's deselected. So it doesn't stay grey even after pressed*/
        /*indexPath below is not capitalised because it's a parameter set in the function*/
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    //MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        /*A scope of the entire IBAction Pressed, which can be accssible inside of any below*/
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        /*what happens when add item button is clicked*/
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem = Items() /*newItem is local object*/
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray") /*Lesson 225*/
            
            /*Reload the data with the data saved in the array*/
            self.tableView.reloadData()
        }
        
        alert.addTextField { (textFieldInAlert) in
            textFieldInAlert.placeholder = "Enter New Item"
            textField = textFieldInAlert
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
}

