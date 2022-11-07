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
    @Published var today: Date = Date()
    @Published var userName: String = "Dajun"
    @Published var noTasksToday: Bool = true
    @Published var number = 0
    @Published var currentTask: Task = Task("", title: "", startingHour: 0, startingMin: 0, hour: 0, min: 0, second: 1)
    @Published var todaysTasks: [Task] = [Task("", title: "", startingHour: 0, startingMin: 0, hour: 0, min: 0, second: 1)]
    
    @Published var tasks: [TaskMetaData] = []
    
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
            }
        }
            
        //if no same date
        if (!hasTasks) {
            let newTaskMetaData = TaskMetaData(task: [newTask], taskDate: inputDate)
            tasks.append(newTaskMetaData)
        }
        
        if (!allCompleted()) {
            noTasksToday = false
            updateCurrentTask()
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
    
    func completeTask() {
        tasks.forEach{ taskOfTheDay in
            if (taskOfTheDay.taskDate.onlyDate == today.onlyDate) {
                taskOfTheDay.completeTask()
            }
        }
        
        if (allCompleted()) {
            noTasksToday = true
        }
        else {
            noTasksToday = false
            updateCurrentTask()
        }
    }
    
    func getTaskNumber() -> Int {
        return getTodaysTasks().count
    }
    
    func getFirstUncompletedTask() -> Task {
        let tempTask = Task("Default",title: "nothing", startingHour: 8, startingMin: 0, hour: 0, min: 0, second: 10)
        for taskOfTheDay in tasks {
            if (taskOfTheDay.taskDate.onlyDate == today.onlyDate) {
                taskOfTheDay.sortTask()
                for task in taskOfTheDay.task.reversed() {
                    if (!task.isCompleted) {
                        currentTask = task
                        return currentTask
                    }
                }
            }
        }
        
        return tempTask
    }
    
    func updateCurrentTask() {
        for taskOfTheDay in tasks {
            if (taskOfTheDay.taskDate.onlyDate == today.onlyDate) {
                taskOfTheDay.sortTask()
                //todaysTasks = taskOfTheDay.task
                for task in taskOfTheDay.task {
                    if (!task.isCompleted) {
                        currentTask = task
                        break
                    }
                }
            }
        }
        updateTodaysUncompletedTasks()
    }
    
    func updateTodaysUncompletedTasks() {
        for taskOfTheDay in tasks {
            var tempTasks: [Task] = [Task("", title: "", startingHour: 0, startingMin: 0, hour: 0, min: 0, second: 1)]
            if (taskOfTheDay.taskDate.onlyDate == today.onlyDate) {
                taskOfTheDay.sortTask()
                tempTasks.removeAll()
                for task in taskOfTheDay.task {
                    if (!task.isCompleted) {
                        tempTasks.append(task)
                    }
                }
                todaysTasks = tempTasks
            }
        }
    }
    
    func printTaskMetaData() {
        tasks.forEach { tasks in
            print()
            print()
            print("--------------------------------------------------")
            print("Meta Task List of", tasks.taskDate.formatted()," contains: ")
            print("--------------------------------------------------")
            tasks.task.forEach { onetask in
                print(onetask.type, " starting at", onetask.startingHour, ":", onetask.startingMin, "   ","Completed?  ",String(onetask.isCompleted))
            }
            print("--------------------------------------------------")
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
}

