//
//  ViewController.swift
//  ToDoApp
//
//  Created by Jose Ignacio Ferrer Vera on 2021-09-27.
//

import UIKit

class GroupsViewController: UIViewController,
                      UITableViewDelegate,
                      UITableViewDataSource{
    
    @IBOutlet weak var myTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Storage.groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : GroupTableViewCell = tableView.dequeueReusableCell(withIdentifier: "myGroupCellID") as! GroupTableViewCell
        
        cell.groupLabel?.text = Storage.groups[indexPath.row].title
        cell.completedLabel?.text = String(Storage.groups[indexPath.row].GetCompleted())
        cell.totalLabel?.text = String(Storage.groups[indexPath.row].items.count)
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "ToDo App"
        
        myTableView.delegate = self
        myTableView.dataSource = self
        
        Storage.Initialize();
    }
}

extension GroupsViewController
{
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete)
        {
            Storage.DeleteGroup(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.left)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Delete group \(Storage.groups[indexPath.row].title!)?"
    }
}

