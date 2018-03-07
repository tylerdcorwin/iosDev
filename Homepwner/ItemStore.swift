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
    let itemArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("items.archive")
    }()
    
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
    init() {
        if let archivedItems = NSKeyedUnarchiver.unarchiveObject(withFile: itemArchiveURL.path) as? [Item] {
            allItems = archivedItems
        }
    }
    
    func removeItem(_ item: Item){
        if let index = allItems.index(of: item) {
            allItems.remove(at: index)
        }
    }
    
    func moveItem(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        //Get reference to object being moved so you can reinsert it
        let movedItem = allItems[fromIndex]
        //Remove item from array
        allItems.remove(at: fromIndex)
        //Insert item in array at new location
        allItems.insert(movedItem, at: toIndex)
    }
    func saveChanges() -> Bool {
        print("Saving items to: \(itemArchiveURL.path)")
        return NSKeyedArchiver.archiveRootObject(allItems, toFile: itemArchiveURL.path)
    }
    
    func imageURL(forKey key: String) -> URL {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        
        return documentDirectory.appendingPathComponent(key)
    }
    
}
