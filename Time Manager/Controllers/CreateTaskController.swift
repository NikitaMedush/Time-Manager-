//
//  CreateTaskController.swift
//  Time Manager
//
//  Created by admin on 15.03.22.
//

import Foundation


class CreateTaskController {
    var model: CreateTaskModel?
    var view: CreateTaskView?
    
    
    func getNumberOfRows() -> Int? {
        return model?.cellName.count

    }
    func getNameCell(for number: Int) -> String? {
        return model?.cellName[number]
    }
    
    
        init(view: CreateTaskView, model: CreateTaskModel) {
            self.view = view
            self.model = model
            
            model.controller = self
            view.controller = self
        }
}
