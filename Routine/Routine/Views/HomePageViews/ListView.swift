//
//  ListView.swift
//  Routine
//
//  Created by Dajun Xian on 10/1/22.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
	@Environment(\.colorScheme) var colorScheme
    //let tasks = Task.sampleTask
    
    var body: some View {
        VStack {
            HStack {
                Text("REMAINS")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding()
					.shadow(color: colorScheme == .dark ? Color.white : Color.clear, radius: 1.0)
                Spacer()
            }
			if (!userViewModel.todaysTasks.showTodayTasks) {
				Section {
					Text("Live your meaningless life today or add some tasks")
						.foregroundColor(colorScheme == .dark ? Color.white : Color.gray)
						.shadow(color: colorScheme == .dark ? Color.white : Color.clear, radius: 1.0)
				}
				.padding()
				.background(.gray.opacity(0.1))
				.cornerRadius(15)
            }
            else {
                List {
					ForEach(userViewModel.todaysTasks.tasks) { task in
						if (!task.passed) {
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

