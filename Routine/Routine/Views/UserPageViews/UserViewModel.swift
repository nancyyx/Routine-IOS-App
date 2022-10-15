//
//  UserViewModel.swift
//  Routine
//
//  Created by Dajun Xian on 10/2/23.
//

import Foundation
import SwiftUI

class UserViewModel: ObservableObject {
   // @Published var tasks: [TaskModel] = []
    @State var today: Date = Date()
    @Published var userName: String = "Dajun"
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
            
        let components = Calendar.current.dateComponents([.hour, .minute], from: inputDate)
        let startingHour = components.hour ?? 0
        let startingMinute = components.minute ?? 0
            
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
            if (taskOfTheDay.taskDate == inputDate) {
                taskOfTheDay.addTask(newTask: newTask)
                return
            }
        }
            
        //if no same date
        let newTaskMetaData = TaskMetaData(task: [newTask], taskDate: inputDate)
        tasks.append(newTaskMetaData)
    }
    
    func getTodaysTasks() -> [Task] {
        var todaysTasks: [Task] = []
        
        tasks.forEach{ taskOfTheDay in
            if (taskOfTheDay.taskDate == today) {
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

