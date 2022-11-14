//
//  CurrentAddButtonView.swift
//  Routine
//
//  Created by Dajun Xian on 10/3/22.
//

import SwiftUI

struct CurrentAddButtonView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    //@State var presentSheet = false
    //let currentTask: TaskModel
    var body: some View {
        ZStack {
            outerCircle()
            
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .scaledToFit()
                .foregroundColor(Color.blue)
                
        }
       
    }
 
    
}

struct outerCircle: View {
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 15)
                .opacity(0.20)
                .foregroundColor(Color.gray)
                .frame(width: 235, height: 235)
            
            Circle()
                .stroke(Color.blue, style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                .padding()
                .frame(width: 225, height: 225)
            
            
            Circle()
                .stroke(Color.blue, style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                .padding()
                .frame(width: 255, height: 225)
            
            
            
        }
    }
}


struct CurrentAddButtonView_Previews: PreviewProvider {
    static var previews: some View {
        //let currentTask = TaskModel("Workout", description: "Today is leg day")
        CurrentAddButtonView()
    }
}
