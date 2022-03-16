//
//  DBManager.swift
//  Time Manager
//
//  Created by admin on 12.03.22.
//

import Foundation
import RealmSwift

class RealmManager {
    private var realm = try! Realm()
    static let sharedInstance = RealmManager()
   
    func getDataFromDB() -> Results<Task> {
        let results = realm.objects(Task.self)
        return results
    }
    func addData(object: Task) {
        try! realm.write {
            realm.add(object)
            print("Added new object")
            print(object)
        }
        
    }
    func deleteAllFromDatabase() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    func deleteFromDb(object: Task) {
        try! realm.write {
            realm.delete(object)
        }
    }
    func reverseArray() -> [Task] {
        let tasks = realm.objects(Task.self)
        var arrayOfTasks = [Task]()
        for item in tasks {
            let newTask = Task()
            newTask.name = item.name
            newTask.definitionTask = item.definitionTask
            newTask.date = item.date
            newTask.repeatEveryday = item.repeatEveryday
            newTask.taskReady = item.taskReady
            arrayOfTasks.append(newTask)
        }
        return arrayOfTasks
    }
}
