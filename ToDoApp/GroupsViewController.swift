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
    
    var destGroupIndex : Int = 0
    
    var isInit = false
    
    var storage : Storage = Storage(groups: [])
    
    let docsURL = try! FileManager.default.url(for: .documentDirectory,
                                              in: .userDomainMask,
                                              appropriateFor: nil,
                                              create: false)
    
    func write()
    {
        let dataPath = docsURL.appendingPathComponent("my_data.plist")
        
        let archiver = try? NSKeyedArchiver.archivedData(withRootObject: self.storage, requiringSecureCoding: false)
        
        try? archiver?.write(to:dataPath)
        
        print(docsURL)
    }
    
    func read()
    {
        let dataPath = docsURL.appendingPathComponent("my_data.plist")
        
        if let data = try? Data(contentsOf: dataPath)
        {
            do{
                let foundStorage = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? Storage
                
                self.storage = foundStorage!
            } catch{
                self.write()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storage.groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : GroupTableViewCell = tableView.dequeueReusableCell(withIdentifier: "myGroupCellID") as! GroupTableViewCell
        
        cell.groupLabel?.text = storage.groups[indexPath.row].title
        cell.completedLabel?.text = String(storage.groups[indexPath.row].GetCompleted())
        cell.totalLabel?.text = String(storage.groups[indexPath.row].items.count)
        cell.selectionStyle = .none
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "ToDo App"
        
        self.read()
        
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.reloadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        myTableView.reloadData()
    }
    
    @IBAction func AlertNewGroup()
    {
        let myAlert = UIAlertController(title: "New Group", message: "Type the name of the new Group", preferredStyle: UIAlertController.Style.alert)
        
        myAlert.addTextField { (newItemTextField) in
            newItemTextField.textAlignment = .center
            newItemTextField.font = .systemFont(ofSize: 16)
            
        }
        
        let okAction = UIAlertAction(title: "Create", style: UIAlertAction.Style.default)
        {(myAlertAction) in
            let newGroupName = myAlert.textFields![0].text!
            
            self.storage.AddGroup(title: newGroupName)
            self.write()
            self.myTableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        
        myAlert.addAction(okAction)
        myAlert.addAction(cancelAction)
        
        self.present(myAlert, animated: true, completion: nil)
    }
}

extension GroupsViewController
{
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete)
        {
            self.storage.DeleteGroup(index: indexPath.row)
            self.write()
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.left)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        self.write()
        return "Delete group \(self.storage.groups[indexPath.row].title)?"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        destGroupIndex = indexPath.row
        
        performSegue(withIdentifier: "groupToItem", sender: tableView.self)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "groupToItem")
        {
            let destinationVC = segue.destination as! ItemsViewController
            
            destinationVC.storage = storage
            destinationVC.groupIndex = destGroupIndex
        }
    }
    
    
}

