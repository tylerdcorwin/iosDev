//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by Corwin, Tyler D on 2/13/18.
//  Copyright © 2018 Corwin, Tyler D. All rights reserved.
//

//import Foundation
import UIKit

class ItemsViewController: UITableViewController {
    var itemStore: ItemStore!
    
    @IBAction func addNewItem(_ sender: UIButton){
//        let lastRow = tableView.numberOfRows(inSection: 0)
//        let indexPath = IndexPath(row: lastRow, section: 0)
        let newItem = itemStore.createItem()
        if let index = itemStore.allItems.index(of: newItem) {
            let indexPath = IndexPath(row: index, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
        
    }
    @IBAction func toggleEditingMode(_ sender: UIButton){
        if isEditing {
            sender.setTitle("Edit", for: .normal)
            
            //turn of edit mode
            setEditing(false, animated: true)
        } else {
            sender.setTitle("Done", for: .normal)
            setEditing(true, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        //create an instance of UITableViewCell with defaut apperance
        //let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        
        //get a new or recycled cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        //set the text on the cell with the description of the item
        //that is at the nth index of items, where n = row this cell
        //will appear in on the tableview
        let item = itemStore.allItems[indexPath.row]
        
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "$\(item.valueInDollars)"
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //get the height of the status bar
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
    }
    
}
