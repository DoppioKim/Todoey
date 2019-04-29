//
//  ViewController.swift
//  Todoey
//
//  Created by Jiyoung on 29/04/2019.
//  Copyright © 2019 Jiyoung Kim. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    
    let itemArray = ["1st item", "2nd item", "3rd item" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    
    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /*Making the cells of tableview reusable cells*/
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        /*setting the text of 'textLabel' of a cell to the items in the itemArray*/
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        /*Giving checkmark when it's clicked*/
        if tableView.cellForRow(at: indexPath)?.accessoryType != .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        
        /*Animating when it's deselected. So it doesn't stay grey even after pressed*/
        /*indexPath below is not capitalised because it's a parameter set in the function*/
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}

