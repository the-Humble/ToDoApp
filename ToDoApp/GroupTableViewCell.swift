//
//  GroupTableViewCell.swift
//  ToDoApp
//
//  Created by Jose Ignacio Ferrer Vera on 2021-10-10.
//

import UIKit

class GroupTableViewCell: UITableViewCell {

    @IBOutlet weak var groupLabel: UILabel?
    @IBOutlet weak var completedLabel: UILabel?
    @IBOutlet weak var totalLabel: UILabel?

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
