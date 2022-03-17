//
//  TaskTableViewCell.swift
//  Time Manager
//
//  Created by admin on 12.03.22.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var taskReadyLabel: UILabel!
    @IBOutlet weak var definitionTaskLabel: UILabel!
    
    override func layoutSubviews() {
//        self.backgroundColor = .clear
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
