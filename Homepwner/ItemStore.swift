//
//  ItemStore.swift
//  Homepwner
//
//  Created by Corwin, Tyler D on 2/13/18.
//  Copyright © 2018 Corwin, Tyler D. All rights reserved.
//

//import Foundation
import UIKit

class ItemStore {
    var allItems = [Item]()
    
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        allItems.append(newItem)
        return newItem
    }
    
//    init() {
//        for _ in 0..<6 {
//            createItem()
//        }
//    }
}
