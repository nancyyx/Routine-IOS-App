//
//  Taskmodel.swift
//  Routine
//
//  Created by Dajun Xian on 10/1/22.
//

import Foundation

// properties: 0.taskType  1. starting time 2. duration 3. repeatness 4. description

struct Task: Identifiable {  //easy to use in loop with identifiable
    
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

extension Task {
    
    static let sampleTask = [
        
        Task("Workout", description: "Today is leg day"),
        Task("Drink", description:  "Drink some chicken juice"),
        Task("Smile", description: "Smile to your roommate"),
        Task("Read", description: "Read the alphabet")
        
    ]
}

