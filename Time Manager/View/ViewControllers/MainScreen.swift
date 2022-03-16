//
//  ViewController.swift
//  Time Manager
//
//  Created by admin on 23.02.22.
//
import RealmSwift
import FSCalendar
import UIKit
import Alamofire
import SwiftUI

class MainScreen: UIViewController {
    var realm = try! Realm()
    var controller: MainScreenController?
    let customCell = "MyCell"
    let calendar = FSCalendar()
    

    @IBOutlet weak var tasksTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createFirstModule()
        setConstraints()
        controller?.model?.tasks.append(contentsOf: RealmManager.sharedInstance.reverseArray())
    }
    
    func createFirstModule() {
        let view = self
        let model = MainScreenModel()
        let controller = MainScreenController(view: view, model: model)
        self.controller = controller
        self.controller?.model?.controller = controller
        tasksTableView.delegate = self
        tasksTableView.dataSource = self
        tasksTableView.bounces = false
        calendar.delegate = self
        calendar.dataSource = self
        let nib = UINib(nibName: "TaskTableViewCell", bundle: nil)
        tasksTableView.register(nib, forCellReuseIdentifier: "MyCell")
        calendar.scope = .week
    }
    
    func setConstraints() {
        
        calendar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(calendar)
        NSLayoutConstraint.activate([
            calendar.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25),
            calendar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            calendar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            calendar.topAnchor.constraint(equalTo: tasksTableView.bottomAnchor, constant: 30)
        ])
        
        tasksTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tasksTableView.heightAnchor.constraint(equalToConstant: 700),
            tasksTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            tasksTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tasksTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            tasksTableView.bottomAnchor.constraint(equalTo: calendar.topAnchor, constant: 10)
        ])
    }
    
    @IBAction func edit(_ sender: Any) {
        tasksTableView.isEditing = !tasksTableView.isEditing
    }
    @IBAction func add(_ sender: Any) {
       guard let createTaskViewController = storyboard?.instantiateViewController(withIdentifier: "CreateTaskViewController") as? CreateTaskViewController else {
            return
        }
        navigationController?.pushViewController(createTaskViewController, animated: true)

        
        
        
//            let alertController = UIAlertController(title: "Добавьте новое задание", message: "Заполните поля", preferredStyle: .alert)
//            alertController.addTextField { textField in
//                textField.placeholder = "Задание" }
//            alertController.addTextField { textField in
//                textField.placeholder = "Описание"  }
//
//            let createButton = UIAlertAction(title: "Добавить", style: .default) {
//                _ in
//                guard let taskName = alertController.textFields?[0].text, let taskDefinition = alertController.textFields?[1].text else {
//                    return
//                }
//                let newTask = Task(name: taskName, definitionTask: taskDefinition, date: Date(), time: Date())
//            DBManager.sharedInstance.addData(object: newTask)
//            self.controller?.model?.tasks = DBManager.sharedInstance.reverseArray()
//            self.tasksTableView.reloadData()
//        }
//        let cancelButton = UIAlertAction(title: "Отменить", style: .cancel, handler: nil)
//        alertController.addAction(cancelButton)
//        alertController.addAction(createButton)
//        self.present(alertController, animated: true, completion: nil)
        
    }
    
}

extension MainScreen: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller?.getNumberOfRows() ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
               guard let myCell = tasksTableView.dequeueReusableCell(withIdentifier: customCell, for: indexPath) as? TaskTableViewCell else {
                    return UITableViewCell()
                }
        
        let task = controller?.getTaskCell(for: indexPath.row)
        myCell.nameLabel.text = task?.name
        myCell.definitionTaskLabel.text = task?.definitionTask
        return myCell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
    
            try! realm.write {
                realm.delete(realm.objects(Task.self).filter("name=%@", controller?.model?.tasks[indexPath.row].name))
            }
            controller?.model?.tasks.remove(at: indexPath.row)
            tasksTableView.reloadData()
        } else if editingStyle == .insert {
        }
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tasksTableView.deselectRow(at: indexPath, animated: true)
        if controller?.changeValueTask(task: indexPath.row) as! Bool {
           tasksTableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            try! realm.write {
                let thisTask = realm.object(ofType: Task.self, forPrimaryKey: controller?.model?.tasks[indexPath.row].name)
                thisTask?.taskReady = true
                print(thisTask?.taskReady)
                print(RealmManager.sharedInstance.getDataFromDB())
            }
       } else {
           try! realm.write {
               let thisTask = realm.object(ofType: Task.self, forPrimaryKey: controller?.model?.tasks[indexPath.row].name)
               thisTask?.taskReady = false
               print(thisTask?.taskReady)
               print(RealmManager.sharedInstance.getDataFromDB())
           }
           tasksTableView.cellForRow(at: indexPath)?.accessoryType = .none
       }
    }
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard let element = controller?.model?.tasks[sourceIndexPath.row] else { return
            
        }
        controller?.model?.tasks.remove(at: sourceIndexPath.row)
        controller?.model?.tasks.insert(element, at: destinationIndexPath.row)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}

extension MainScreen: FSCalendarDataSource, FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(date)
//        let calendar = Calendar.current
//        let components = calendar.dateComponents([.weekday], from: date)
//        guard let weekday = components.weekday else {
//            return
//            }
//        print(weekday)
//        let predicateRepeat = NSPredicate(format: "repeatEveryday = \(weekday) = true")
//        controller?.model?.tasksDB = realm.objects(Task.self).filter(predicateRepeat)
//
    }
}









