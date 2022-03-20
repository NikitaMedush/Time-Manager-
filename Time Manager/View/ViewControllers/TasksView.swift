//
//  ViewController.swift
//  Time Manager
//
//  Created by admin on 23.02.22.
//
import RealmSwift
import FSCalendar
import UIKit
import SwiftUI

class TasksView: UIViewController {
    var realm = try! Realm()
    var controller: MainScreenController?
    let customCell = "MyCell"
    let calendar = FSCalendar()
    var tasksDB: Results<Task>?

    @IBOutlet weak var tasksTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createFirstModule()
        setConstraints()
        activationСalendar(date: calendar.today!)
        controller?.model?.tasks.append(contentsOf: RealmManager.sharedInstance.reverseArray())
        view.backgroundColor = .systemOrange
        tasksTableView.backgroundColor = .clear
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
        calendar.scope = .month
    }
    
    func activationСalendar(date: Date) {
        let dateStart = date
        let dateEnd: Date = {
            let components = DateComponents(day: 1, second: -1)
            return Calendar.current.date(byAdding: components, to: dateStart)!
        }()
        
        controller?.model?.tasksDB = realm.objects(Task.self).filter("dateTask BETWEEN %@", [dateStart, dateEnd])

        tasksTableView.reloadData()
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
            tasksTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tasksTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            tasksTableView.bottomAnchor.constraint(equalTo: calendar.topAnchor, constant: 10)
        ])
    }
    

    @IBAction func add(_ sender: Any) {
       guard let createTaskViewController = storyboard?.instantiateViewController(withIdentifier: "CreateTaskViewController") as? CreateTaskView else {
            return
        }
        navigationController?.pushViewController(createTaskViewController, animated: true)
    }
}

extension TasksView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        controller?.model?.tasksDB?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
               guard let myCell = tasksTableView.dequeueReusableCell(withIdentifier: customCell, for: indexPath) as? TaskTableViewCell else {
                    return UITableViewCell()
                }

        let task = controller?.model?.tasksDB?[indexPath.row]
        myCell.configCell(task: task as! Task)
        return myCell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            guard let task = controller?.model?.tasksDB?[indexPath.row] else {
                return
            }
            RealmManager.sharedInstance.deleteFromDb(object: task)
            
            tasksTableView.reloadData()
            
        } else if editingStyle == .insert {
        }
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tasksTableView.deselectRow(at: indexPath, animated: false)
        let task = controller?.model?.tasksDB?[indexPath.row]
        RealmManager.sharedInstance.updateObject(task: task as! Task, newValue: !(task?.readyTask ?? false))
        tasksTableView.reloadData()

           print(RealmManager.sharedInstance.getDataFromDB())

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
        100
    }
}

extension TasksView: FSCalendarDataSource, FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        activationСalendar(date: date)
//        let calendar = Calendar.current
//        let components = calendar.dateComponents([.weekday], from: date)
//        guard let weekday = components.weekday else {
//            return
//            }

//        let dateStart = date
//        let dateEnd: Date = {
//            let components = DateComponents(day: 1, second: -1)
//            return Calendar.current.date(byAdding: components, to: dateStart)!
//        }()
        
//        let predicateRepeat = NSPredicate(format: "repeatTask = \(weekday) AND weekdayTask = true")
//        let predicateUnrepeat = NSPredicate(format: "repeatTask = false AND dateTask BETWEEN %@", [dateStart, dateEnd])
//        let compound = NSCompoundPredicate(type: .or, subpredicates: [predicateRepeat,predicateUnrepeat])
//        controller?.model?.tasksDB = realm.objects(Task.self).filter(compound)
//        print(RealmManager.sharedInstance.getDataFromDB())
        
    }
}









