//
//  HomeView.swift
//  Routine
//
//  Created by Dajun Xian on 10/1/22.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        
        VStack {
            CurrentView()
            ListView()
            Spacer()
        }
        .padding(.top, 80.0)
        //.statusBar(hidden: true)  //mindful!!
        .ignoresSafeArea(edges: .top)   //maybe
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(PomodoroModel())
            .environmentObject(UserViewModel())
    }
}
