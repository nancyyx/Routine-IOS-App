//
//  UserModel.swift
//  Routine
//
//  Created by Dajun Xian on 10/1/22.
//

import Foundation

struct User: Identifiable {
    let id = UUID()
    
    let name: String
    let tasks: [Task]  //tasklist
    
    //init function
    
}
