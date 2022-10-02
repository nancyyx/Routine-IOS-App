//
//  ListView.swift
//  Routine
//
//  Created by Dajun Xian on 10/1/22.
//

import SwiftUI

struct ListView: View {
    
    let tasks = Task.sampleTask
    
    var body: some View {
        VStack {
            HStack {
                Text("TODO LIST")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                Spacer()
            }
            List {
                    ForEach(tasks) { task in
                        ListWithIcon(task: task)
                    }
            }
            .listStyle(.plain)
        }
    }
}






struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ListView()
        }

    }
}

