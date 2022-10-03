//
//  CurrentDynamicButtonView.swift
//  Routine
//
//  Created by Dajun Xian on 10/1/22.
//

import SwiftUI

struct CurrentDynamicButtonView: View {
    let currentTask: Task
    var body: some View {
        Button {
            print("Image tapped!")
        } label: {
            Image(currentTask.type)
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
               // .aspectRatio(0.1, contentMode: .fit)
                .scaledToFit()
                .padding()
                .overlay(Circle().stroke(Color.cyan, lineWidth: 10))
                .padding()
                .overlay(Circle().stroke(Color.blue, lineWidth: 10))
        }
        .padding()
        
    }
    //.statusBar(hidden: true)
}

struct CurrentDynamicButtonView_Previews: PreviewProvider {
    static var previews: some View {
        let currentTask = Task.sampleTask[0]
        CurrentDynamicButtonView(currentTask: currentTask)
    }
}
