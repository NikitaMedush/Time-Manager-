//
//  TasksList Model.swift
//  Time Manager
//
//  Created by admin on 2.03.22.
//

import Foundation
import UIKit
import RealmSwift


class MainScreenModel {
    var controller: MainScreenController?
    var tasks = [Task]()
    var tasksDB: Results <Task>?
}






