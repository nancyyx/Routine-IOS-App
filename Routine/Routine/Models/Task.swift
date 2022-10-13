//
//  Task.swift
//  Routine
//
//  Created by Chang on 10/7/22.
//
import SwiftUI

// Task Model and Sample Tasks...
// Array of Tasks...
class Task: Identifiable, Comparable {
    static func == (lhs: Task, rhs: Task) -> Bool {
        if lhs.id == rhs.id {
            return true
        }
        else{
            return false
        }
    }
    
    static func < (lhs: Task, rhs: Task) -> Bool {
        if lhs.startingHour < rhs.startingHour {
            return true
        }
        else if lhs.startingHour == rhs.startingHour {
            if lhs.startingMin < rhs.startingMin {
                return true
            }
            else {
                return false
            }
        }
        else {
            return false
        }
    }
    
    let id = UUID()
    let type: String                    //workout, smile, drink
    let title: String                   //description
    @State var isCompleted: Bool
    let time: Date = Date()             //task date

    var startingHour: Int
    var startingMin: Int

    var hour: Int
    var min: Int
    var second: Int
    

    
    init(_ type: String, title: String, startingHour: Int, startingMin: Int, hour: Int, min: Int, second: Int) {
        self.type = type
        self.title = title
        self.isCompleted = false
        self.hour = hour
        self.min = min
        self.second = second
        self.startingHour = startingHour
        self.startingMin = startingMin
    }
    
    func complete(){
        self.isCompleted = true
    }
}

// Total Task Meta View...
class TaskMetaData: Identifiable{
    var id = UUID().uuidString
    var task: [Task]
    var taskDate: Date
    var completedTasksCounter: Int
    
    
    init(task: [Task], taskDate: Date) {
        self.task = task
        self.taskDate = taskDate
        completedTasksCounter = 0
    }
    
    func sortTask() {
        task.sort()
    }
    
    func addTask(newTask: Task) {
        task.append(newTask)
        sortTask()
    }
    
    func completeTask(taskID: UUID) {
        task.forEach { tempTask in
            if (taskID == tempTask.id) {
                tempTask.complete()
            }
        }
    }
    
    
    

    
}

// sample Date for Testing...
func getSampleDate(offset: Int)->Date{
    let calender = Calendar.current
    
    let date = calender.date(byAdding: .day, value: offset, to: Date())
    
    return date ?? Date()
}

/*
// Sample Tasks...
var tasks: [TaskMetaData] = [

    TaskMetaData(task: [
    
        Task("Workout",title: "Talk to Dajun🤣"),
        Task("Workout",title: "A Leetcode per day🤖"),
        Task("Workout",title: "Nothing Much Workout !!!🍩")
    ], taskDate: getSampleDate(offset: 1)),
    
    TaskMetaData(task: [
        
        Task("Workout",title: "CSCI 198 Assignment👩‍💻")
    ], taskDate: getSampleDate(offset: -3)),
    TaskMetaData(task: [
        
        Task("Workout",title: "Meeting with Tim Cook")
    ], taskDate: getSampleDate(offset: -8)),
    TaskMetaData(task: [
        
        Task("Workout",title: "Next Version of SwiftUI📲")
    ], taskDate: getSampleDate(offset: 10)),
    TaskMetaData(task: [
        
        Task("Workout",title: "Nothing Much Workout !!!")
    ], taskDate: getSampleDate(offset: -22)),
    TaskMetaData(task: [
        
        Task("Workout",title: "Meet with Navid📆")
    ], taskDate: getSampleDate(offset: 15)),
    TaskMetaData(task: [
        
        Task("Workout",title: "Keto Diet...🍣")
    ], taskDate: getSampleDate(offset: -20)),
]
*/

