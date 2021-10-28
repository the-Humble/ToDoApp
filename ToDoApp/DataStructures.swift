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
        newGroup.groupID = UUID().uuidString
        newGroup.title = title
        groups.append(newGroup)
    }
    
    static func AddItem(groupIndex:Int, title:String)
    {
        let newItem = Item()
        newItem.title = title
        newItem.groupID = groups[groupIndex].groupID
        newItem.itemID = UUID().uuidString
        groups[groupIndex].items.append(newItem)
    }
    
    static func DeleteGroup(index:Int)
    {
        groups[index].items.removeAll()
        groups.remove(at: index)
    }
    
    static func Initialize()
    {
        let group1 = Group()
        group1.title = "Groceries"
        group1.groupID = UUID().uuidString
        
        let item1 = Item()
        item1.title = "Apples"
        item1.itemID = UUID().uuidString
        item1.groupID = group1.groupID
        
        let item2 = Item()
        item2.title = "Pears"
        item2.itemID = UUID().uuidString
        item2.groupID = group1.groupID
        
        group1.items.append(item1)
        group1.items.append(item2)
        
        let group2 = Group()
        group2.title = "Store"
        group2.groupID = UUID().uuidString
        
        let item3 = Item()
        item3.title = "Socks"
        item3.itemID = UUID().uuidString
        item3.groupID = group2.groupID
        
        group2.items.append(item3)
        
        groups.append(group1)
        groups.append(group2)
    }
}
