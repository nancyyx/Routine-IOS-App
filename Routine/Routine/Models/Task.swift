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
    @Published var isCompleted: Bool
    var time: Date = Date()             //task date

    var startingHour: Int
    var startingMin: Int

    var hour: Int
    var min: Int
    var second: Int
    
    
    init(_ type: String, title: String, startingHour: Int, startingMin: Int, hour: Int, min: Int, second: Int, time: Date) {
        self.time = time
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
class TaskMetaData: Identifiable, ObservableObject {
    var id = UUID().uuidString
    @Published var task: [Task]
    @Published var taskDate = Date()
    @Published var completedTasksCounter: Int = 0
    @Published var showTodayTasks:Bool = false
    
    init(task: [Task], taskDate: Date) {
        self.task = task
        self.taskDate = taskDate
        completedTasksCounter = 0
        showTodayTasks = true
    }
    
    func sortTask() {
        task.sort()
    }
    
    func addTask(newTask: Task) {
        task.append(newTask)
        sortTask()
        showTodayTasks = true
    }
    
    func completeTask() {
        for tempTask in task {
            if (!tempTask.isCompleted) {
                tempTask.complete()
                break
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


/*
 - 从以下几个大类寻找相应图标，再在assets里归类存放。命名使用常规变量命名, 如 payBill
 - 大类可以自由补充，子类别可以根据图库实际情况增添删减
 - 看到合适的图标，但不方便归类的，可以直接和大类别放在同一层级
 
 大类别：
 
    经济类： 付账单， 还钱
 
    健康类： 健身，买药，去医院……
 
    家务类： ……
 
    自我提升类： 看教科书，复习，写作业，上网课……
 
    工作类：无小类别。直接一个图标
 
    其他类：一个general 图标
 
 
 
 
 
 
 */


