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
    @Published var userAvatar: UIImage?
    @Published var today: Date = Date()
    @Published var todaysLastTaskEndTime: Date = Date()
    @Published var userName: String = "Remy"
    @Published var sup: String = "I love 996"
    // @Published var noTasksToday: Bool = true
    //@Published var number = 0
    @Published var currentTask: Task = Task("nothinghere",title: "Keto Diet...🍣", startingHour: 8, startingMin: 0, hour: 0, min: 0, second: 10, time: Date())
    @Published var todaysTasks: TaskMetaData = TaskMetaData()
    
    @Published var tasksOfYear: [TaskMetaData] = []
    /*
    init() {
        addTaskToOneDate(type: "Workout", title: "Workout with everybody in this class", inputDate: Date().addingTimeInterval(35.0), hour: 0, min: 0, second: 10)
        addTaskToOneDate(type: "Dumping", title: "Dump your android phone", inputDate: Date().addingTimeInterval(50.0), hour: 0, min: 0, second: 5)
        addTaskToOneDate(type: "Laundry", title: "Wash your neighbor's shoes", inputDate: Date().addingTimeInterval(55.0), hour: 0, min: 0, second: 3)
        addTaskToOneDate(type: "Hospital", title: "Visit doctor everyday", inputDate: Date().addingTimeInterval(59.0), hour: 0, min: 0, second: 3)
    }
     */
    
    func setInfo(name: String, wasup: String) {
        userName = name
        sup = wasup
    }
    
    func addTaskToOneDate(
        type: String,
        title: String,
        inputDate: Date,
        hour: Int,
        min: Int,
        second: Int) {
            // number += 1
            let components = Calendar.current.dateComponents([.hour, .minute], from: inputDate)
            let startingHour = components.hour ?? 0
            let startingMinute = components.minute ?? 0
            
            var tasksOfDateExist: Bool = false
            
            let newTask = Task(
                type,
                title: title,
                startingHour: startingHour,
                startingMin: startingMinute,
                hour: hour,
                min: min,
                second: second,
                time: inputDate)
            //if there's same date
            
            tasksOfYear.forEach{ tasksOfDate in
                if (tasksOfDate.taskDate.onlyDate == inputDate.onlyDate) {
                    tasksOfDateExist = true
                    if (tasksOfDate.addTask(newTask: newTask)) {
                        print("57")
                    }
                    else {
                        print("60")
                    }
                    //tasksOfDate.sortTask()
                }
            }
            
            //if no same date
            if (!tasksOfDateExist) {
                let newTaskMetaData = TaskMetaData(tasks: [newTask], taskDate: inputDate)
                tasksOfYear.append(newTaskMetaData)
            }
            
            
            
            /*
             if (!allCompleted()) {
             
             
             }
             
             if (inputDate.onlyDate == Date().onlyDate) {
                 refreshTodaysTasks()
                 refreshCurrentTask()
             }
             */
            refreshTodaysTasks()
            refreshCurrentTask()
            
            
            
        }
    /*
     func getTodaysTasks() -> [Task] {
     var todaysTasks: [Task] = []
     
     tasksOfYear.forEach{ tasksOfDate in
     if (tasksOfDate.taskDate.onlyDate == today.onlyDate) {
     todaysTasks = tasksOfDate.tasks
     }
     }
     return todaysTasks
     }
     */
    
    
    
    func refreshCurrentTask() {
        for task in todaysTasks.tasks {
            if (!task.passed) {
                currentTask = task
                break
            }
        }
        // updateTodaysUncompletedTasks()
    }
    
    func refreshTodaysTasks() {
        tasksOfYear.forEach{ tasksOfDate in
            if (tasksOfDate.taskDate.onlyDate == today.onlyDate) {
                todaysTasks = tasksOfDate
            }
        }
    }
    
    func completeTask() {
        tasksOfYear.forEach{ tasksOfDate in
            if (tasksOfDate.taskDate.onlyDate == today.onlyDate) {
                tasksOfDate.completeTask()
                todaysTasks = tasksOfDate
            }
        }
        
        refreshTodaysTasks()
        refreshCurrentTask()
    }
    
    func inCompleteTask() {
        tasksOfYear.forEach{ tasksOfDate in
            if (tasksOfDate.taskDate.onlyDate == today.onlyDate) {
                tasksOfDate.inCompleteTask()
                todaysTasks = tasksOfDate
            }
        }
        
        
        refreshTodaysTasks()
        refreshCurrentTask()
        
        //todaysTasks.inCompleteTask()
    }
    

    
    func printTodaysTasks() {
        todaysTasks.tasks.forEach { onetask in
            print(onetask.type, " starting at", onetask.startingHour, ":", onetask.startingMin, "   ","Completed?  ",String(onetask.isCompleted), "Passed?", String(onetask.passed))
        }
    }
    /*
     func getTaskNumber() -> Int {
     return getTodaysTasks().count
     }
     */
    
    /*
     func getFirstUncompletedTask() -> Task {
     let tempTask = Task("Default",title: "nothing", startingHour: 8, startingMin: 0, hour: 0, min: 0, second: 10, time: Date())
     for tasksOfDate in tasksOfYear {
     if (tasksOfDate.taskDate.onlyDate == today.onlyDate) {
     tasksOfDate.sortTask()
     for task in tasksOfDate.tasks.reversed() {
     if (!task.isCompleted) {
     currentTask = task
     return currentTask
     }
     }
     }
     }
     
     return tempTask
     }
     */
    
    
    /*
     
     func updateTodaysUncompletedTasks() {
     for tasksOfDate in tasksOfYear {
     var tempTasks: [Task] = [Task("", title: "", startingHour: 0, startingMin: 0, hour: 0, min: 0, second: 1, time: Date())]
     if (tasksOfDate.taskDate.onlyDate == today.onlyDate) {
     tasksOfDate.sortTask()
     tempTasks.removeAll()
     for task in tasksOfDate.tasks {
     if (!task.isCompleted) {
     tempTasks.append(task)
     }
     }
     todaysTasks = tempTasks
     }
     }
     }
     */
    
    func printTaskMetaData() {
        tasksOfYear.forEach { tasks in
            print()
            print("======================Today's Tasks =======================")
            print()
            printTodaysTasks()
            print()
            print("============================================================")
            
            print()
            print()
            print()
            print("--------------------------------------------------")
            print("Meta Task List of", tasks.taskDate.formatted()," contains: ")
            print("--------------------------------------------------")
            tasks.tasks.forEach { onetask in
                print(onetask.type, " starting at", onetask.startingHour, ":", onetask.startingMin, "   ","Completed?  ",String(onetask.isCompleted), "Passed?", String(onetask.passed))
            }
            print("--------------------------------------------------")
        }
    }
    /*
     
     func allPassed() -> Bool {
     var passed: Bool = true
     tasksOfYear.forEach{ tasksOfDate in
     if (tasksOfDate.taskDate.onlyDate == today.onlyDate) {
     tasksOfDate.tasks.forEach { task in
     passed = passed && task.isCompleted
     }
     }
     }
     return passed
     }
     */
}

