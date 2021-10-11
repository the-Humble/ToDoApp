//
//  DataStructures.swift
//  ToDoApp
//
//  Created by Jose Ignacio Ferrer Vera on 2021-10-10.
//

import Foundation


class Group
{
    var groupID: String?
    var title: String?
    var items: [Item] = []
    
    func GetCompleted() -> Int
    {
        var count = 0
        for item in items {
            if(item.completed)
            {
                count+=1
            }
        }
        return count
    }
}

class Item
{
    var groupID: String?
    var itemID: String?
    var title: String?
    var completed = false;
}

class Storage
{
    static var groups : [Group] = []
    
    static func AddGroup(title:String)
    {
        let newGroup = Group()
        groups.append(newGroup)
    }
    
    static func DeleteGroup(index:Int)
    {
        groups[index].items.removeAll()
        groups.remove(at: index)
    }
    
    static func Initialize()
    {
        var group1 = Group()
        group1.title = "Groceries"
        group1.groupID = UUID().uuidString
        
        var item1 = Item()
        item1.title = "Apples"
        item1.itemID = UUID().uuidString
        item1.groupID = group1.groupID
        
        group1.items.append(item1)
        
        var group2 = Group()
        group2.title = "Store"
        group2.groupID = UUID().uuidString
        
        groups.append(group1)
        groups.append(group2)
    }
}
