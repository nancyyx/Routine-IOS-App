//
//  ListWithIcon.swift
//  Routine
//
//  Created by Dajun Xian on 10/1/22.
//

import SwiftUI

struct ListWithIcon: View {
    

    let task: Task
    
    
    var body: some View {
        HStack {
            Image(task.type)
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
               // .aspectRatio(0.1, contentMode: .fit)
                .scaledToFit()
            VStack {
                HStack {
                    Text(task.type)
                        .font(.body)
                    .fontWeight(.semibold)
                    Spacer()
                }
                HStack {
                    Text(task.title)
                        .font(.body)
                    .fontWeight(.light)
                    Spacer()
                }
            }
            Spacer()
        }
        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        
        
        
    }
}

struct ListWithIcon_Previews: PreviewProvider {
    static var previews: some View {
        let testTask = Task("Workout",title: "Keto Diet...🍣", startingHour: 8, startingMin: 0, hour: 0, min: 0, second: 10, time: Date())
        ListWithIcon(task: testTask )
    }
}
