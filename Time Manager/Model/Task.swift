//
//  Task.swift
//  Time Manager
//
//  Created by admin on 2.03.22.
//


import RealmSwift
import Foundation

class Task: Object {
    
    
    @Persisted(primaryKey: true) var nameTask: String = ""
    @Persisted var definitionTask: String = ""
    @Persisted var readyTask: Bool = false
    @Persisted var repeatTask: Bool = false
    @Persisted var dateTask: Date?
//    @Persisted var timeTask: Date
    @Persisted var weekdayTask: Int = 1
    convenience init(nameTask: String, definitionTask: String, readyTask: Bool = false, repeatEveryday: Bool = false, dateTask: Date?, weekdayTask: Int)
    {
        self.init()
        self.nameTask = nameTask
        self.readyTask = readyTask
        self.definitionTask = definitionTask
        self.repeatTask = repeatEveryday
        self.dateTask = dateTask
//        self.timeTask = timeTask
        self.weekdayTask = weekdayTask
    }
}
