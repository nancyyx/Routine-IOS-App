//
//  UserViewModel.swift
//  Routine
//
//  Created by Dajun Xian on 10/2/22.
//

import Foundation
import SwiftUI

class UserViewModel: ObservableObject {
   // @Published var tasks: [TaskModel] = []
    @State var today: Date = Date()
    @Published var userName: String = "Dajun"
    @Published var number = 0
    @Published var tasks: [TaskMetaData] = [
        
        TaskMetaData(task: [
            Task("Workout",title: "Talk to Dajun🤣",startingHour: 8, startingMin: 0, hour: 0, min: 0, second: 10),
            Task("Workout",title: "A Leetcode per day🤖",startingHour: 8, startingMin: 0, hour: 0, min: 0, second: 10),
            Task("Workout",title: "Nothing Much Workout !!!🍩",startingHour: 8, startingMin: 0, hour: 0, min: 0, second: 10)
        ], taskDate: getSampleDate(offset: 1)),
        
        TaskMetaData(task: [
            
            Task("Workout",title: "CSCI 198 Assignment👩‍💻",startingHour: 8, startingMin: 0, hour:0,  min: 0, second: 10)
        ], taskDate: getSampleDate(offset: -3)),
        TaskMetaData(task: [
            
            Task("Workout",title: "Meeting with Tim Cook",startingHour: 8, startingMin: 0, hour: 0, min: 0, second: 10)
        ], taskDate: getSampleDate(offset: -8)),
        TaskMetaData(task: [
            
            Task("Workout",title: "Next Version of SwiftUI📲", startingHour: 8, startingMin: 0, hour: 0, min: 0, second: 10)
        ], taskDate: getSampleDate(offset: 10)),
        TaskMetaData(task: [
            
            Task("Workout",title: "Nothing Much Workout !!!", startingHour: 8, startingMin: 0, hour: 0, min: 0, second: 10)
        ], taskDate: getSampleDate(offset: -22)),
        TaskMetaData(task: [
            
            Task("Workout",title: "Meet with Navid📆",startingHour: 8, startingMin: 0, hour: 0, min: 0, second: 10)
        ], taskDate: getSampleDate(offset: 15)),
        TaskMetaData(task: [
            
            Task("Workout",title: "Keto Diet...🍣", startingHour: 8, startingMin: 0, hour: 0, min: 0, second: 10)
        ], taskDate: getSampleDate(offset: -20)),
    ]
    
    func addTaskToOneDate(
        type: String,
        title: String,
        inputDate: Date,
        hour: Int,
        min: Int,
        second: Int) {
            
        number += 1
            
        let components = Calendar.current.dateComponents([.hour, .minute], from: inputDate)
        let startingHour = components.hour ?? 0
        let startingMinute = components.minute ?? 0
        
        var hasTasks: Bool = false
            
        let newTask = Task(
            type,
            title: title,
            startingHour: startingHour,
            startingMin: startingMinute,
            hour: hour,
            min: min,
            second: second)
            
        //if there's same date
        tasks.forEach{ taskOfTheDay in
            if (taskOfTheDay.taskDate.onlyDate == inputDate.onlyDate) {
                hasTasks = true
                taskOfTheDay.addTask(newTask: newTask)
                taskOfTheDay.sortTask()
                print("84")
            }
        }
            
        //if no same date
        if (!hasTasks) {
            let newTaskMetaData = TaskMetaData(task: [newTask], taskDate: inputDate)
            tasks.append(newTaskMetaData)
            print("90")
        }
            
        
    }
    
    func getTodaysTasks() -> [Task] {
        var todaysTasks: [Task] = []
        
        tasks.forEach{ taskOfTheDay in
            if (taskOfTheDay.taskDate.onlyDate == today.onlyDate) {
                todaysTasks = taskOfTheDay.task
            }
        }
        return todaysTasks
    }
    
    func completeTask(taskID: UUID) {
        tasks.forEach{ taskOfTheDay in
            if (taskOfTheDay.taskDate == today) {
                taskOfTheDay.completeTask(taskID: taskID)
            }
        }
    }
    
    func getTaskNumber() -> Int {
        return getTodaysTasks().count
    }
    
    func getFirstUncompletedTask() -> Task {
        var tempTask = Task("Default",title: "nothing", startingHour: 8, startingMin: 0, hour: 0, min: 0, second: 10)
        tasks.forEach { taskOfTheDay in
            if (taskOfTheDay.taskDate.onlyDate == today.onlyDate) {
                taskOfTheDay.task.forEach { task in
                    if (!task.isCompleted) {
                        tempTask = task
                    }
                }
            }
        }
        return tempTask
    }
    
    func printTaskMetaData() {
        tasks.forEach { tasks in
            print("Meta Task List of", tasks.taskDate.formatted()," contains: ")
            tasks.task.forEach { onetask in
                print(onetask.type)
                print(onetask.time)
            }
            print(" ")
        }
    }
    
    func allCompleted() -> Bool {
        var completed: Bool = true
        tasks.forEach{ taskOfTheDay in
            if (taskOfTheDay.taskDate.onlyDate == today.onlyDate) {
                taskOfTheDay.task.forEach { task in
                    completed = completed && task.isCompleted
                }
            }
        }
        return completed
    }
/*
 func testTask() {
     let newTasks = [
         TaskModel("Workout", description: "Today is leg day"),
         TaskModel("Drink", description:  "Drink some chicken juice"),
         TaskModel("Smile", description: "Smile to your roommate"),
         TaskModel("Read", description: "Read the alphabet")
     ]
     tasks.append(contentsOf: newTasks)
 }



    func addNewTask(type: String, title: String, taskDate: Date) {
        let newTask = Task(type, title: title)
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
 
 */
}

