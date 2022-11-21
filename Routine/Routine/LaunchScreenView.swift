//
//  LaunchScreenView.swift
//  Routine
//
//  Created by Dajun Xian on 11/15/22.
//

import SwiftUI


struct LaunchScreenView: View {
    
    @StateObject var userViewModel: UserViewModel = UserViewModel()
    @StateObject var pomodoroModel: PomodoroModel = .init()
    @State private var isActive = false
    @State private var opacity  = 0.5
    @State private var size = 0.3
    
    var body: some View {
        if isActive {
            NavigationView {
                TabBarView()
            }
            .environmentObject(userViewModel)
            //.environmentObject(todaysList)
            .environmentObject(pomodoroModel)
        } else {
            /*
            VStack {
                VStack {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.red)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
            }*/
            CircleAnimation()
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
            .background(Color.black)
        }
        
        
    }
}


struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}
