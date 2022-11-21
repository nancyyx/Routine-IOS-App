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
    @Published var passed: Bool
    var time: Date = Date()             //task date
    
    var startingHour: Int
    var startingMin: Int

    var hour: Int
    var min: Int
    var second: Int
    var endTime: Date
    
    init(_ type: String, title: String, startingHour: Int, startingMin: Int, hour: Int, min: Int, second: Int, time: Date) {
        self.time = time
        self.type = type
        self.title = title
        self.isCompleted = false
        self.passed = false
        self.hour = hour
        self.min = min
        self.second = second
        self.startingHour = startingHour
        self.startingMin = startingMin
        self.endTime = time.addingTimeInterval(Double(hour * 3600 + min * 60 + second * 1))
    }
    
    func complete(){
        self.isCompleted = true
    }
    
    func pass() {
        self.passed = true
    }
    
    func getDuration() -> String {
        var duration = ""
    
        duration += String(self.hour)
        duration += ":"
        if (self.min < 10) {
            duration += String("0") + String(self.min)
        }
        else {
            duration += String(self.min)
        }
        duration += ":"
        if (self.second < 10) {
            duration += String("0") + String(self.second)
        }
        else {
            duration += String(self.second)
        }
        return duration
    }
}

// Total Task Meta View...
class TaskMetaData: Identifiable, ObservableObject {
    var id = UUID().uuidString
    @Published var tasks: [Task]
    @Published var taskDate: Date
    @Published var completedTasksCounter : Int
    @Published var showTodayTasks:Bool = false
    @Published var endTime: Date
    @Published var completePercentage: Double
    
    init() {
        self.tasks = [ Task("Workout",title: "Keto Diet...🍣", startingHour: 8, startingMin: 0, hour: 0, min: 0, second: 10, time: Date())]
        self.taskDate = Date()
        completedTasksCounter = 0
        showTodayTasks = false
        endTime = Date()
        completePercentage = 0.0
    }
    
    init(tasks: [Task], taskDate: Date) {
        self.tasks = tasks
        self.taskDate = taskDate
        completedTasksCounter = 0
        showTodayTasks = true
        endTime = tasks[0].time.addingTimeInterval(Double(tasks[0].hour * 3600 + tasks[0].min * 60 + tasks[0].second * 1))
        completePercentage = 0.0
    }
    
    func sortTask() {
        tasks.sort()
    }
    
    /*
    func addTask(newTask: Task) {
        task.append(newTask)
        sortTask()
        showTodayTasks = true
    }
     */
    
    func addTask(newTask: Task)->Bool {
        for index in tasks.indices {
            let endTime = tasks[index].time.addingTimeInterval(Double(tasks[index].hour * 3600 + tasks[index].min * 60 + tasks[index].second * 1))
            let newTaskEndTime = newTask.time.addingTimeInterval(Double(newTask.hour * 3600 + newTask.min * 60 + newTask.second * 1))
            if (newTask.time > endTime) {
                if (index + 1 < tasks.count) {   // if there's next task in this day
                    if (newTaskEndTime < tasks[index + 1].time) {    // check if the new task's end time is less than the start time of next task
                        tasks.insert(newTask, at: index + 1)
                        showTodayTasks = true
                        refreshCompletePercentage()
                        return true
                    }
                }
                else {
                    tasks.append(newTask)
                    showTodayTasks = true
                    refreshCompletePercentage()
                    return true
                }
            }
        }
        return false
    }
    
    
    func completeTask() {
        for tempTask in tasks {
            if (!tempTask.passed && !tempTask.isCompleted) {
                tempTask.pass()
                tempTask.complete()
                break
            }
        }
        
        if (allPassed()) {
            showTodayTasks = false
        }
        
        refreshCompletePercentage()
 
    }
    
    func inCompleteTask() {
        for tempTask in tasks {
            if (!tempTask.passed && !tempTask.isCompleted) {
                tempTask.pass()
                break
            }
        }
        if (allPassed()) {
            showTodayTasks = false
        }
        
        refreshCompletePercentage()
 
    }
    
    
    func allPassed() -> Bool {
        var passed: Bool = true
        tasks.forEach{ task in
            passed = passed && task.passed
        }
        return passed
        
    }
    
    func refreshCompletePercentage()  {
        var completed = 0.0
        for task in tasks {
            if (task.isCompleted) {
                completed += 1.0
            }
        }
       completePercentage = completed / Double(tasks.count)
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


