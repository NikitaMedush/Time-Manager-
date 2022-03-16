//
//  Task.swift
//  Time Manager
//
//  Created by admin on 2.03.22.
//


import RealmSwift
import Foundation

class Task: Object {
    
    
    @Persisted(primaryKey: true) var name: String = ""
    @Persisted var definitionTask: String = "описание"
    @Persisted var taskReady: Bool = false
    @Persisted var repeatEveryday: Bool = false
    @Persisted var date = Date()
   
    convenience init(name: String, definitionTask: String, taskReady: Bool = false, repeatEveryday: Bool = false, date: Date, time: Date)
    {
        self.init()
        self.name = name
        self.taskReady = taskReady
        self.definitionTask = definitionTask
        self.repeatEveryday = repeatEveryday
        self.date = date
    }
}
