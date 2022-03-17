//
//  MainScreenController.swift
//  Time Manager
//
//  Created by admin on 2.03.22.
//

import Foundation
import UIKit


class MainScreenController {
    var view: MainScreen?
    var model: MainScreenModel?
    var createTaskController: CreateTaskController?
    
    func getNumberOfRows() -> Int? {
        return model?.tasks.count
    }

    
    func getTaskCell(for number: Int) -> Task? {
        return model?.tasks[number]
    }
    
    func changeValueTask(task: Int) -> Bool {
        
        model?.tasks[task].taskReady = !(model?.tasks[task].taskReady as! Bool)
        
        return model?.tasks[task].taskReady as! Bool
    }
    
    
    func createSecondModule() {
        let viewCreateScreen = view?.storyboard?.instantiateViewController(withIdentifier: "CreateTaskViewController")
        let modelCreateScreen =  CreateTaskModel()
        let controllerCreateScreen = CreateTaskController(view: viewCreateScreen as! CreateTaskViewController, model: modelCreateScreen as! CreateTaskModel)
        self.createTaskController = controllerCreateScreen
        self.createTaskController?.model?.controller = controllerCreateScreen
    }

    
    init(view: MainScreen, model: MainScreenModel) {
        self.view = view
        self.model = model
        
        view.controller = self
        model.controller = self
    }
}
