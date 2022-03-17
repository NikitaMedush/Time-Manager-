//
//  CreateTaskTableViewCell.swift
//  Time Manager
//
//  Created by admin on 15.03.22.
//

import UIKit

class CreateTaskTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var repeadEverydaySwitch: UISwitch!

    
    
    func switchIsHidden(indexPath: IndexPath) {
        repeadEverydaySwitch.isOn = false
        if indexPath.row == 4 {
            repeadEverydaySwitch.isOn = false
        } else {
            repeadEverydaySwitch.isHidden = true
        }
    }
}
