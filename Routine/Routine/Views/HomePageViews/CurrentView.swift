//
//  CurrentView.swift
//  Routine
//
//  Created by Dajun Xian on 10/1/22.
//

import SwiftUI


struct CurrentView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var pomodoroModel: PomodoroModel
    @Environment(\.colorScheme) var colorScheme
    //@EnvironmentObject var todaysTasks: TaskMetaData
    //@State private var flag = false
    
    var body: some View {
        VStack {
            HStack {
                Text("CURRENT")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding()
                    .shadow(color: colorScheme == .dark ? Color.white : Color.clear, radius: 1.0)
                
                Spacer()
            }
            if (userViewModel.noTasksToday) {
                CurrentAddButtonView()
                    .padding(/*@START_MENU_TOKEN@*/[.leading, .bottom, .trailing], 50.0/*@END_MENU_TOKEN@*/)
                //userViewModel.updateTaskNumber(taskNumber: 0)
                
            }
            else {
                /*
                    CircleSPin()
                    .frame(width: 300, height: 300)
                    .padding(/*@START_MENU_TOKEN@*/[.leading, .bottom, .trailing], 50.0/*@END_MENU_TOKEN@*/)
                    //.colorInvert()
                */
               CurrentDynamicButtonView()
                   
            }
            
        }
        //.statusBar(hidden: true)
        //.padding()
    }
}

struct CurrentView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentView()
            .environmentObject(UserViewModel())
            .environmentObject(PomodoroModel())

    }
}
