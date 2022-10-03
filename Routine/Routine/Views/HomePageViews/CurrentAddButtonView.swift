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
                .frame(width: 150.0, height: 150.0)
                .padding(20.0)
            
         
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
                .stroke(lineWidth: 20.0)
                .opacity(0.20)
                .foregroundColor(Color.gray)
            
            Circle()
                //.trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 12, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.blue)
                //.rotationEffect(Angle(degrees: 270))
                //.animation(.easeInOut(duration: 1.5))
            
        }
    }
}


struct CurrentAddButtonView_Previews: PreviewProvider {
    static var previews: some View {
        //let currentTask = TaskModel("Workout", description: "Today is leg day")
        CurrentAddButtonView()
    }
}
