//
//  CreateTaskTableViewCell.swift
//  Time Manager
//
//  Created by admin on 15.03.22.
//

import UIKit

class CreateTaskTableViewCell: UITableViewCell {
    
    @IBOutlet weak var createNameLabel: UILabel!
    @IBOutlet weak var repeadEverydaySwitch: UISwitch!

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func switchIsHidden(indexPath: IndexPath) {
        repeadEverydaySwitch.isOn = false
        if indexPath.row == 4 {
            repeadEverydaySwitch.isOn = false
        } else {
            repeadEverydaySwitch.isHidden = true
        }
    }
}
