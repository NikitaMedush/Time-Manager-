//
//  CreateTaskViewController.swift
//  Time Manager
//
//  Created by admin on 15.03.22.
//

import UIKit

class CreateTaskViewController: UIViewController {
    @IBOutlet weak var createTaskTableView: UITableView!
    var controller: CreateTaskController?
    
    
    let customCell = "customCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createSecondModule()
       
    }
    func createSecondModule() {
        let view = self
        let model = CreateTaskModel()
        let controller = CreateTaskController(view: view, model: model)
        self.controller = controller
        self.controller?.model?.controller = controller
        createTaskTableView.dataSource = self
        createTaskTableView.delegate = self
        createTaskTableView.bounces = false
        let nib = UINib(nibName: "CreateTaskTableViewCell", bundle: nil)
        createTaskTableView.register(nib, forCellReuseIdentifier: customCell)
    }

 
}

extension CreateTaskViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        controller?.getNumberOfRows() ?? 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let createCell = createTaskTableView.dequeueReusableCell(withIdentifier: customCell, for: indexPath) as? CreateTaskTableViewCell else { return UITableViewCell()
        }
        createCell.createNameLabel.text = controller?.model?.cellName[indexPath.row]
        createCell.switchIsHidden(indexPath: indexPath)
        return createCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = createTaskTableView.cellForRow(at: indexPath) as! CreateTaskTableViewCell
        switch indexPath.row {
        case 0: alertForCellName(label: cell.createNameLabel, name: "Укажите имя задачи", placeholder: "Введите текст")
        case 1: alertForCellName(label: cell.createNameLabel, name: "Укажите описание задачи", placeholder: "Введите текст")
        case 2: alertDate(label: cell.createNameLabel) { (numberWeekday , date) in
            print(numberWeekday, date)
        }
        case 3: alertTime(label: cell.createNameLabel) { (date) in
            print(date)
        }
        default: break 
        }
    }
}
