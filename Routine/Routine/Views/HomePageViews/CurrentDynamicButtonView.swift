//
//  CurrentDynamicButtonView.swift
//  Routine
//
//  Created by Dajun Xian on 10/1/22.
//

import SwiftUI

struct CurrentDynamicButtonView: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var pomodoroModel: PomodoroModel
    
    @State var progressValue: Float = 0.0
    
    let currentTask: TaskModel
    
    var body: some View {
        
        ZStack {
            ProgressBar(progress: self.$progressValue)
                .frame(width: 235, height: 235)
                .padding(20.0)
                .onAppear() {
                    self.progressValue = 0.00
                }
            
            Button {
                print("Image tapped!")
                clickIcon()
                if pomodoroModel.isStarted {
                    pomodoroModel.stopTimer()
                }else{
                    pomodoroModel.startTimer()
                }
            } label: {
                Image(currentTask.type)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
            }
            Circle()
                .stroke(lineWidth: 15.0)
                .opacity(0.20)
                .foregroundColor(Color.gray)
                .frame(width: 235, height: 235)

            
            Circle()
                .trim(from: 0, to: pomodoroModel.progress)
                .stroke(Color.cyan, style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                .padding()
                .rotationEffect(.init(degrees: -90))
                .frame(width: 225, height: 225)

            
        }
        .animation(.easeInOut, value: pomodoroModel.progress)
        .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()){
            _ in
            if pomodoroModel.isStarted {
                pomodoroModel.updateTimer()
            }
        }
        .alert("Congrats", isPresented: $pomodoroModel.isFinished) {
            Button("Close", role: .destructive) {
                pomodoroModel.stopTimer()
            }
            Button("Start Relax Time", role: .cancel) {
                pomodoroModel.stopTimer()
                pomodoroModel.minute = 5
                pomodoroModel.startTimer()
                pomodoroModel.addNewTimer = true
            }
        }
        
        /*
        Button {
            print("Image tapped!")
            clickIcon()
        } label: {
            
            ZStack {
                Image(currentTask.type)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                   // .aspectRatio(0.1, contentMode: .fit)
                    .scaledToFit()
                    .padding()
                    .overlay(Circle().stroke(Color.red.opacity(0.4), lineWidth: 10))
                    .padding()
                .overlay(Circle().stroke(Color.blue.opacity(0.2), lineWidth: 10))
                /*
                Image(currentTask.type)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                   // .aspectRatio(0.1, contentMode: .fit)
                    .scaledToFit()
                    .padding()
                    .overlay(Circle().stroke(Color.red, lineWidth: 10))
                    .padding()
                    .overlay(
                        Circle()
                            .trim(from: 0.0, to: <#T##CGFloat#>(min(self.progress, 1.0)))
                            .stroke(style: StrokeStyle(lineWidth: 12, lineCap: .round, lineJoin: .round))
                            .foregroundColor(Color.blue)
                            .rotationEffect(Angle(degrees: 270))
                            .animation(.easeInOut(duration: 1.5))
                    )
                 */
            }
        }
        .padding()
        */
    }
    //.statusBar(hidden: true)
    
    
    func clickIcon() {
        let incrementValue: Float = 1.0 / Float(userViewModel.getTaskNumber())
        userViewModel.completeTask()
        //if (userViewModel.)
        print(Float(1/userViewModel.getTaskNumber()))
        self.progressValue += incrementValue
        //self.progressValue += 1.0
    }
}

struct ProgressBar: View {
    @Binding var progress: Float
    var color: Color = Color.blue
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.20)
                .foregroundColor(Color.gray)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 12, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.blue)
                .rotationEffect(Angle(degrees: 270))
                .animation(.easeInOut(duration: 1.5))
        }
        
    }
}

struct CurrentDynamicButtonView_Previews: PreviewProvider {
    static var previews: some View {
        let currentTask = TaskModel("Workout", description: "Today is leg day")
        CurrentDynamicButtonView(currentTask: currentTask)
    }
}
