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
             
             return cell
         }
         

         override func viewDidLoad() {
             super.viewDidLoad()
             // Do any additional setup after loading the view.
             self.title = Storage.groups[groupIndex].title
             
             myTableView.delegate = self
             myTableView.dataSource = self
             
             Storage.Initialize();
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
     }


