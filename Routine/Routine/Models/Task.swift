//
//  Task.swift
//
//  Created by Chang.
//

import SwiftUI

// Task Model and Sample Tasks...
// Array of Tasks...
struct Task: Identifiable{
    var id = UUID().uuidString
    var title: String
    var time: Date = Date()
}

// Total Task Meta View...
struct TaskMetaData: Identifiable{
    var id = UUID().uuidString
    var task: [Task]
    var taskDate: Date
}

// sample Date for Testing...
func getSampleDate(offset: Int)->Date{
    let calender = Calendar.current
    
    let date = calender.date(byAdding: .day, value: offset, to: Date())
    
    return date ?? Date()
}

// Sample Tasks...
var tasks: [TaskMetaData] = [

    TaskMetaData(task: [
    
        Task(title: "Talk to Dajun🤣"),
        Task(title: "A Leetcode per day🤖"),
        Task(title: "Nothing Much Workout !!!🍩")
    ], taskDate: getSampleDate(offset: 1)),
    TaskMetaData(task: [
        
        Task(title: "CSCI 198 Assignment👩‍💻")
    ], taskDate: getSampleDate(offset: -3)),
    TaskMetaData(task: [
        
        Task(title: "Meeting with Tim Cook")
    ], taskDate: getSampleDate(offset: -8)),
    TaskMetaData(task: [
        
        Task(title: "Next Version of SwiftUI📲")
    ], taskDate: getSampleDate(offset: 10)),
    TaskMetaData(task: [
        
        Task(title: "Nothing Much Workout !!!")
    ], taskDate: getSampleDate(offset: -22)),
    TaskMetaData(task: [
        
        Task(title: "Meet with Navid📆")
    ], taskDate: getSampleDate(offset: 15)),
    TaskMetaData(task: [
        
        Task(title: "Keto Diet...🍣")
    ], taskDate: getSampleDate(offset: -20)),
]
