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
        return
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "ToDo App"
        
        myTableView.delegate = self
        myTableView.dataSource = self
    }


}

