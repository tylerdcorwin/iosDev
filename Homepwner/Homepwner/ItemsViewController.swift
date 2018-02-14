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
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
}
