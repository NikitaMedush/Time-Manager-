//
//  TaskTableViewCell.swift
//  Time Manager
//
//  Created by admin on 12.03.22.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var definitionTaskLabel: UILabel!
    
    @IBOutlet weak var readyTaskLabel: UILabel!
    
    
    func configCell(task: Task) {
        nameLabel.text = task.nameTask
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        timeLabel.text = dateFormatter.string(from: task.dateTask as! Date)
        definitionTaskLabel.text = task.definitionTask
        self.layer.cornerRadius = 15
        if task.readyTask == true {
            readyTaskLabel.text = "Выполнено"
            self.backgroundColor = .green
        } else {
            readyTaskLabel.text = "Не выполнено"
            self.backgroundColor = .red
        }
    }
    
}
