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
    //@State var currentTask: Task

    var body: some View {

        ZStack {
            ProgressBar(progress: self.$progressValue)
                .frame(width: 235, height: 235)
                .padding(20.0)
                .onAppear() {
                    self.progressValue = 0.00
                }

            Button{
                print("Image tapped!")
            } label: {
                Image(userViewModel.currentTask.type)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
            }
            .simultaneousGesture(
                TapGesture()
                    .onEnded { _ in
                        if pomodoroModel.isStarted {
                            pomodoroModel.stopTimer()
//                            pomodoroModel.hour = userViewModel.currentTask.hour
//                            pomodoroModel.minute = userViewModel.currentTask.min
//                            pomodoroModel.second = userViewModel.currentTask.second
                            print("Break Time!")
                            pomodoroModel.startTimer()
                            pomodoroModel.addNewTimer = true
                        }
                    }
            )
            .highPriorityGesture(LongPressGesture (minimumDuration: 2)
                                    .onEnded{ _ in
                                        clickIcon()
                                        if pomodoroModel.isStarted {
                                            pomodoroModel.stopTimer()
                                            pomodoroModel.minute = 5
                                            print("Break Time!")
                                            pomodoroModel.startTimer()
                                            pomodoroModel.addNewTimer = true
                                        }
                                })

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
            
            if (!userViewModel.allCompleted()) {
                
                if (!pomodoroModel.isStarted) {
                    let calendar = Calendar.current
                    let date = Date()
                    let hour = calendar.component(.hour, from: date)
                    let minute = calendar.component(.minute, from: date)
                    if hour == userViewModel.currentTask.startingHour && (minute == userViewModel.currentTask.startingMin || minute == userViewModel.currentTask.startingMin + 1) && pomodoroModel.isStarted == false {
                        pomodoroModel.startTimer()
                    }
                } else {
                    pomodoroModel.updateTimer()

                }
        
            }
        }
        .alert("Congrats", isPresented: $pomodoroModel.isFinished) {
            Button("Close", role: .destructive) {
                userViewModel.completeTask()
                pomodoroModel.stopTimer()
            }
            Button("Start Relax Time", role: .cancel) {
                userViewModel.completeTask()
                pomodoroModel.stopTimer()
                pomodoroModel.minute = 5
                pomodoroModel.startTimer()
                pomodoroModel.addNewTimer = true
            }
        }
    }


    func clickIcon() {
        let incrementValue: Float = 1.0 / Float(userViewModel.getTaskNumber())
        self.progressValue += incrementValue
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
        //let currentTask = TaskModel("Workout", description: "Today is leg day")
        let currentTask = Task("Workout",title: "Keto Diet...🍣", startingHour: 8, startingMin: 0, hour: 0, min: 0, second: 10)
        CurrentDynamicButtonView()
    }
}
