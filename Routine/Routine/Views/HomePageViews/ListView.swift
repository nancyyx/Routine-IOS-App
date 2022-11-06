//
//  ListView.swift
//  Routine
//
//  Created by Dajun Xian on 10/1/22.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    //let tasks = Task.sampleTask
    
    var body: some View {
        VStack {
            HStack {
                Text("TODO LIST")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                Spacer()
            }
            if (userViewModel.noTasksToday) {
                Text("Live your meaningless life today or add some tasks")
            }
            else {
                List {
                    ForEach(userViewModel.todaysTasks) { task in
                        if (!task.isCompleted) {
                            ListWithIcon(task: task)
                        }
                            
                    }
                }
                .listStyle(.plain)
            }
        }
        
    }
}






struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ListView()
                .environmentObject(UserViewModel())
        }

    }
}

