//
//  UserViewModel.swift
//  Routine
//
//  Created by Dajun Xian on 10/2/22.
//

import Foundation

class UserViewModel: ObservableObject {
    @Published var tasks: [TaskModel] = []
    @Published var user = UserModel(name: "Dajun", taskNumber: 4)
    
    init() {
        testTask()
        //testUser()
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
    
    func updateTaskNumber(taskNumber: Int) {
        user.taskNumber = taskNumber
    }
    
    func incrementTaskNumber() {
        user.taskNumber = user.taskNumber + 1
    }
    
    func getTaskNumber() -> Int {
        return user.taskNumber
    }
    /*
    func decrementTaskNumber() {
        user.taskNumber = user.taskNumber - 1
    }
     */
}

