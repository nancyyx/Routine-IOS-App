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
    
    var body: some View {
        VStack {
            HStack {
                Text("CURRENT")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding()
                
                Spacer()
            }
            if (userViewModel.getTodaysTasks().isEmpty || userViewModel.allCompleted()) {
                CurrentAddButtonView()
                    .padding(/*@START_MENU_TOKEN@*/[.leading, .bottom, .trailing], 50.0/*@END_MENU_TOKEN@*/)
                //userViewModel.updateTaskNumber(taskNumber: 0)
                
            }
            else {
                CurrentDynamicButtonView(currentTask: userViewModel.getFirstUncompletedTask())
                    .padding(/*@START_MENU_TOKEN@*/[.leading, .bottom, .trailing], 50.0/*@END_MENU_TOKEN@*/)
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
