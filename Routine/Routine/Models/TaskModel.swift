//
//  Taskmodel.swift
//  Routine
//
//  Created by Dajun Xian on 10/1/22.
//

import Foundation

// properties: 0.taskType  1. starting time 2. duration 3. repeatness 4. description

struct TaskModel: Identifiable {  //easy to use in loop with identifiable
    
    let id = UUID()
    
    let type: String   //workout, smile, drink
    let description: String
    let isCompleted: Bool
    //starting time
    //duration
    //repeatness (Every Monday, Friday...)
    //let time: time_value     //duration, not sure about the type yet
    
    
    init(_ type: String, description: String) {
        self.type = type
        self.description = description
        self.isCompleted = false
    }
    
    
}
/*
extension TaskModel {
    
    static let sampleTask = [
        
        TaskModel("Workout", description: "Today is leg day"),
        TaskModel("Drink", description:  "Drink some chicken juice"),
        TaskModel("Smile", description: "Smile to your roommate"),
        TaskModel("Read", description: "Read the alphabet")
        
    ]
}
*/
