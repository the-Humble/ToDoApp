//
//  DataStructures.swift
//  ToDoApp
//
//  Created by Jose Ignacio Ferrer Vera on 2021-10-10.
//

import Foundation


class Group : NSObject, NSCoding
{
    
    var groupID: String
    var title: String
    var items: Array<Item> = []
    
    init(groupID: String, title:String, items:Array<Item>)
    {
        self.groupID = groupID
        self.title = title
        self.items = items
    }
    
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
    
    func encode(with coder: NSCoder) {
        coder.encode(self.groupID, forKey: "groupID")
        coder.encode(self.title, forKey: "groupTitle")
        coder.encode(self.items, forKey: "groupItems")
    }
    
    required convenience init?(coder: NSCoder) {
        let id = coder.decodeObject(forKey: "groupID") as! String
        let title = coder.decodeObject(forKey: "groupTitle") as! String
        let items = coder.decodeObject(forKey: "groupItems") as! Array<Item>
        
        self.init(groupID: id, title: title, items: items)
    }
}

class Item : NSObject, NSCoding
{
       
    var groupID: String
    var itemID: String
    var title: String
    var completed = false;
    
    init(groupID: String, itemID: String, title: String, completed: Bool)
    {
        self.groupID = groupID
        self.itemID = itemID
        self.title = title
        self.completed = completed
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.groupID, forKey: "groupID")
        coder.encode(self.itemID, forKey: "itemID")
        coder.encode(self.title, forKey: "title")
        coder.encode(self.completed, forKey: "completed")
    }
    
    required convenience init?(coder: NSCoder) {
        let groupID = coder.decodeObject(forKey: "groupID") as! String
        let itemID = coder.decodeObject(forKey: "itemID") as! String
        let title = coder.decodeObject(forKey: "title") as! String
        let completed = coder.decodeBool(forKey: "completed")
        
        self.init(groupID: groupID, itemID: itemID, title: title, completed: completed)
    }
}

class Storage :NSObject, NSCoding
{
    
    var groups : Array<Group> = []
    
    init(groups: Array<Group>)
    {
        self.groups = groups
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.groups, forKey: "groups")
    }
    
    required convenience init?(coder: NSCoder) {
        let groupsArr = coder.decodeObject(forKey: "groups") as! Array<Group>
        
        self.init(groups: groupsArr)
    }
    
    func AddGroup(title:String)
    {
        let newGroup = Group(groupID: UUID().uuidString, title: title, items: [])
        groups.append(newGroup)
    }
    
    func AddItem(groupIndex:Int, title:String)
    {
        let newItem = Item(groupID: groups[groupIndex].groupID, itemID: UUID().uuidString, title: title, completed: false)
        groups[groupIndex].items.append(newItem)
    }
    
    func DeleteGroup(index:Int)
    {
        groups[index].items.removeAll()
        groups.remove(at: index)
    }
}
