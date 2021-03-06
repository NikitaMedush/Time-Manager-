//
//  CreateTaskViewController.swift
//  Time Manager
//
//  Created by admin on 15.03.22.
//

import UIKit
import RealmSwift

class CreateTaskView: UIViewController {
    
    
    @IBOutlet weak var createTaskTableView: UITableView!
    @IBOutlet weak var saveButton: UIButton!
    var controller: CreateTaskController?
    let customCell = "customCell"
    var newTask = Task()
    override func viewDidLoad() {
        super.viewDidLoad()
        createSecondModule()
        setConstraints()
        createTaskTableView.backgroundColor = .clear
        view.backgroundColor = .systemOrange
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
    
    func setConstraints() {
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: createTaskTableView.bottomAnchor, constant: 15),
            saveButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0)
        ])
        
        createTaskTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            createTaskTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            createTaskTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            createTaskTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            createTaskTableView.heightAnchor.constraint(equalToConstant: 500)
        ])
    }
    @IBAction func saveTaskButton(_ sender: Any) {
        RealmManager.sharedInstance.addData(object: newTask)
        guard let ViewController = storyboard?.instantiateViewController(withIdentifier: "MainScreen") as? TasksView else {
             return
         }
         navigationController?.pushViewController(ViewController, animated: true)
    }
    
 
}

extension CreateTaskView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        controller?.getNumberOfRows() ?? 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let createCell = createTaskTableView.dequeueReusableCell(withIdentifier: customCell, for: indexPath) as? CreateTaskTableViewCell else { return UITableViewCell()
        }
        createCell.config()
        createCell.nameLabel.text = controller?.model?.cellName[indexPath.row]
        createCell.switchIsHidden(indexPath: indexPath)
        return createCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = createTaskTableView.cellForRow(at: indexPath) as! CreateTaskTableViewCell
        
        switch indexPath.row {
        case 0:
            alertForCellName(label: cell.nameLabel, name: "?????????????? ?????? ????????????", placeholder: "?????????????? ??????????") { (text) in
            self.newTask.nameTask = text
        }
        case 1:
            alertForCellName(label: cell.nameLabel, name: "?????????????? ???????????????? ????????????", placeholder: "?????????????? ??????????") { (text) in
                self.newTask.definitionTask = text
        }
        case 2:
            alertDate(label: cell.nameLabel) { (numberWeekday , date) in
            self.newTask.dateTask = date
            self.newTask.weekdayTask = numberWeekday
        }
        case 3:
            self.newTask.repeatTask = cell.repeadEverydaySwitch.isOn.self
        default: break 
        }
        
  
        
        
    }
}
