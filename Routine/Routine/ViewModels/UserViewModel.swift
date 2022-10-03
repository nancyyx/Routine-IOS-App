//
//  UserViewModel.swift
//  Routine
//
//  Created by Dajun Xian on 10/2/22.
//

import Foundation

class UserViewModel: ObservableObject {
    //@Published var user: UserModel
    @Published var tasks: [TaskModel] = []
    
    init() {
        testTask()
    }
    


    func testTask() {
        let newTasks = [
            TaskModel("Workout", description: "Today is leg day"),
            TaskModel("Drink", description:  "Drink some chicken juice"),
            TaskModel("Smile", description: "Smile to your roommate"),
            TaskModel("Read", description: "Read the alphabet")
        ]
        tasks.append(contentsOf: newTasks)
    }
    
    func addNewTask(title: String, description: String) {
        let newTask = TaskModel(title, description: description)
        tasks.append(newTask)
    }
    
    func completeTask() {
        tasks.removeFirst()
    }
}

