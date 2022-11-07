//
//  RoutineApp.swift
//  Routine
//
//  Created by Dajun Xian on 10/1/22.
//

import SwiftUI

@main
struct RoutineApp: App {
    
    @StateObject var userViewModel: UserViewModel = UserViewModel()
    @StateObject var pomodoroModel: PomodoroModel = .init()
    //@StateObject var todaysList: TaskMetaData = TaskMetaData()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                TabBarView()
            }
            .environmentObject(userViewModel)
            //.environmentObject(todaysList)
            .environmentObject(pomodoroModel)
        }
    }
}

