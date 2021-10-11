//
//  ItemsViewController.swift
//  ToDoApp
//
//  Created by Jose Ignacio Ferrer Vera on 2021-10-10.
//

import UIKit

class ItemsViewController: UIViewController,
                           UITableViewDelegate,
                           UITableViewDataSource{
         
         @IBOutlet weak var myTableView: UITableView!
         
        var groupIndex : Int = 0
    
    
         func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
             return Storage.groups[groupIndex].items.count
         }
         
         func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             
             let cell : ItemTableViewCell = tableView.dequeueReusableCell(withIdentifier: "myItemCellID") as! ItemTableViewCell
             
             cell.itemLabel?.text = Storage.groups[groupIndex].items[indexPath.row].title
             cell.backgroundColor = UIColor.systemBackground
             cell.selectionStyle = .none
             
             if(Storage.groups[groupIndex].items[indexPath.row].completed)
             {
                 cell.backgroundColor = UIColor.systemGray
             }
             
             return cell
         }
         

         override func viewDidLoad() {
             super.viewDidLoad()
             // Do any additional setup after loading the view.
             self.title = Storage.groups[groupIndex].title
             
             myTableView.delegate = self
             myTableView.dataSource = self
             myTableView.reloadData()
             
             
         }
    
        @IBAction func AlertNewItem()
        {
            let myAlert = UIAlertController(title: "New Item", message: "Type the name of the new Item", preferredStyle: UIAlertController.Style.alert)
            
            myAlert.addTextField { (newItemTextField) in
                newItemTextField.textAlignment = .center
                newItemTextField.font = .systemFont(ofSize: 16)
                
            }
            
            let okAction = UIAlertAction(title: "Create", style: UIAlertAction.Style.default)
            {(myAlertAction) in
                let newItemName = myAlert.textFields![0].text!
                
                Storage.AddItem(groupIndex: self.groupIndex, title: newItemName)
                self.myTableView.reloadData()
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
            
            myAlert.addAction(okAction)
            myAlert.addAction(cancelAction)
            
            self.present(myAlert, animated: true, completion: nil)
        }
     }

     extension ItemsViewController
     {
         
         func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
             if(editingStyle == .delete)
             {
                 Storage.groups[groupIndex].items.remove(at: indexPath.row)
                 tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.left)
             }
         }
         
         func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
             return "Delete item \(Storage.groups[groupIndex].items[indexPath.row].title!)?"
         }
         
         func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
             Storage.groups[groupIndex].items[indexPath.row].completed = !Storage.groups[groupIndex].items[indexPath.row].completed
             
             tableView.reloadData()
         }
     }


