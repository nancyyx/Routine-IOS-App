//
//  CurrentDynamicButtonView.swift
//  Routine
//
//  Created by Dajun Xian on 10/1/22.
//

import SwiftUI

struct CurrentDynamicButtonView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    let currentTask: TaskModel
    var body: some View {
        Button {
            print("Image tapped!")
            clickIcon()
        } label: {
            Image(currentTask.type)
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
               // .aspectRatio(0.1, contentMode: .fit)
                .scaledToFit()
                .padding()
                .overlay(Circle().stroke(Color.red, lineWidth: 10))
                .padding()
                .overlay(Circle().stroke(Color.blue, lineWidth: 10))
        }
        .padding()
        
    }
    //.statusBar(hidden: true)
    
    
    func clickIcon() {
        userViewModel.completeTask()
    }
}


struct CurrentDynamicButtonView_Previews: PreviewProvider {
    static var previews: some View {
        let currentTask = TaskModel("Workout", description: "Today is leg day")
        CurrentDynamicButtonView(currentTask: currentTask)
    }
}
