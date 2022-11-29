//
//  TaskTypeModel.swift
//  Routine
//
//  Created by Dajun Xian on 11/28/22.
//

import Foundation


struct TaskType: Identifiable {
    var id: Int = 0
    var name: String
    var taskOfTypes: [TaskOfType]
}

struct City: Identifiable {
    var id: Int = 0
    var name: String
}

struct TaskOfType: Identifiable {
    var id: Int = 0
    var name: String
}

class TaskTypeModel: ObservableObject {
    @Published var id: UUID = UUID()
    
    let taskTypes: [TaskType] = [
        TaskType(id: 0, name: "General", taskOfTypes: [TaskOfType(id: 0, name: "General")]),
        TaskType(id: 1, name: "Self Improvement", taskOfTypes: [
            TaskOfType(id: 0, name: "Study"),
            TaskOfType(id: 1, name: "Work"),
            TaskOfType(id: 2, name: "Read"),
            TaskOfType(id: 3, name: "Homework"),
            TaskOfType(id: 4, name: "Meeting"),
            TaskOfType(id: 5, name: "Writing")
        ]),
        TaskType(id: 2, name: "Housework", taskOfTypes: [
            TaskOfType(id: 0, name: "Clean"),
            //TaskOfType(id: 1, name: "Work"),
            TaskOfType(id: 2, name: "Dumping"),
            TaskOfType(id: 3, name: "Laundry")
        ]),
        TaskType(id: 3, name: "Health", taskOfTypes: [
            TaskOfType(id: 0, name: "Drink"),
            TaskOfType(id: 1, name: "Dining"),
            TaskOfType(id: 2, name: "Sleep"),
            TaskOfType(id: 3, name: "Workout"),
            TaskOfType(id: 4, name: "Hospital")
        ]),
        TaskType(id: 4, name: "Economics", taskOfTypes: [
            TaskOfType(id: 0, name: "Pay"),
            TaskOfType(id: 1, name: "Stock")
        ])
    ]

    @Published var selectedTaskType: Int = 0 {
        willSet {
            selectedTaskOfType = taskOfTypeSelections[newValue] ?? 0
            id = UUID()
        }
    }
    
    @Published var selectedTaskOfType: Int = 0 {
        willSet {
            DispatchQueue.main.async { [newValue] in
                //print("city changed", newValue)
                self.taskOfTypeSelections[self.selectedTaskType] = newValue
            }
        }
    }
    
    var taskTypeNames: [String] {
        taskTypes.map { (taskType) in
            taskType.name
        }
    }
    
    var taskOfTypeNamesCount: Int {
        taskOfTypeNames.count
    }
    
    
    
    var taskOfTypeNames: [String] {
        taskTypes[selectedTaskType].taskOfTypes.map { (taskOfType) in
            taskOfType.name
        }
    }

    private var taskOfTypeSelections: [Int: Int] = [:]
    
    
}
