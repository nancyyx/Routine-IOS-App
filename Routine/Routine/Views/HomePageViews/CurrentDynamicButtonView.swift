//
//  CurrentDynamicButtonView.swift
//  Routine
//
//  Created by Dajun Xian on 10/1/22.
//

import SwiftUI

struct CurrentDynamicButtonView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var pomodoroModel: PomodoroModel
    
    /*   animation vars */
    @State var whiteOpacity = 0.7
    @State var stateValue = 1.0
    @State var rotate = -1
    @State var degree = 30
    @State var rotate2 = 5
    @State var degree2 = 150
    @State var t = 0.0
    
    let timer2 = Timer.publish(every: 0.2, on: .main, in:
            .common).autoconnect()
    /*   animation vars */

    @State var progressValue: Float = 0.0
    //@State var currentTask: Task
    
    var body: some View {
        
        VStack(spacing: 20) {
            ZStack {
                
                //___________________________ mid button with icon___________________________
                
                Circle()
                    .frame(width: 100, height: 100)
                    .foregroundColor( colorScheme == .dark ? Color.white : Color.clear)
                //.shadow(color: colorScheme == .dark ? Color.white.opacity(whiteOpacity*5) : Color.clear, radius:  whiteOpacity*30)
                    .shadow(color: colorScheme == .dark ? Color.white.opacity(0.7) : Color.red, radius: 8 + 5 * sin(t), x: sin(t)*2, y: -sin(2*t)*2)
                    .overlay(
                        Button{
                            print("Image tapped!")
                        } label: {
                            Image(userViewModel.currentTask.type)
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .scaledToFit()
                                .foregroundColor(Color.black)
                        }
                            .highPriorityGesture(LongPressGesture (minimumDuration: 2)
                                .onEnded{ _ in
                                    //clickIcon()
                                    if pomodoroModel.isStarted {
                                        pomodoroModel.stopTimer()
                                        pomodoroModel.minute = 1
                                        print("Break Time!")
                                        pomodoroModel.startTimer()
                                        pomodoroModel.addNewTimer = true
                                        userViewModel.completeTask()
                                    }
                                })
                        
                    )
                
                
                
                
                //___________________________timer track__________________________________
                Circle()
                    .stroke(Color.gray.opacity(0.2), style: StrokeStyle(lineWidth: 23, lineCap: .round, lineJoin: .round))
                    .frame(maxWidth: 180)
                    .padding()
                
                // ___________________________timer________________________________________
                Circle()
                    .trim(from: 0, to: pomodoroModel.progress)
                    .stroke(Color.cyan, style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                    //.padding()
                    .rotationEffect(.init(degrees: -90))
                    .frame(maxWidth: 180)
                
                
                // ___________________________progress bar track___________________________
                Circle()
                    .stroke(lineWidth: 23)
                    .opacity(0.20)
                    .foregroundColor(Color.gray)
                    .frame(maxWidth: 250, maxHeight: 250)
                
                // ___________________________progress bar__________________________________
               
                    Circle()
                        .trim(from: 0.0, to: CGFloat(min(userViewModel.todaysTasks.completePercentage, 1.0)))
                        .stroke(colorScheme == .dark ? Color.white.opacity(0.8) : Color.blue.opacity(0.8), style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                        .rotationEffect(Angle(degrees: 270))
                        .frame(maxWidth: 250, maxHeight: 250)
                        .animation(.easeInOut, value: 1.5)
    
                
            }
            //        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .animation(.easeInOut, value: pomodoroModel.progress)
            .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()){
                _ in
                if (userViewModel.todaysTasks.showTodayTasks) {
                    let calendar = Calendar.current
                    let date = Date()
                    let hour = calendar.component(.hour, from: date)
                    let minute = calendar.component(.minute, from: date)
                    pomodoroModel.hour = userViewModel.currentTask.hour
                    pomodoroModel.minute = userViewModel.currentTask.min
                    pomodoroModel.second = userViewModel.currentTask.second
                    
                    if hour == userViewModel.currentTask.startingHour && (minute == userViewModel.currentTask.startingMin || minute == userViewModel.currentTask.startingMin + 1) && pomodoroModel.isStarted == false && pomodoroModel.staticTotalSeconds == 0 {
                        print("start")
                        pomodoroModel.startTimer()
                    }
                }
                if (pomodoroModel.isStarted) {
                    pomodoroModel.updateTimer()
                }
                
            }
            .alert("Congrats", isPresented: $pomodoroModel.isFinished) {
                Button("Close", role: .destructive) {
                    
                    userViewModel.completeTask()
                    pomodoroModel.stopTimer()
                    
                    //clickIcon()
                    userViewModel.printTaskMetaData()
                }
                Button("Start Relax Time", role: .cancel) {
                    let calendar = Calendar.current
                    let date = Date()
                    let hour = calendar.component(.hour, from: date)
                    let minute = calendar.component(.minute, from: date)
                    let second = calendar.component(.second, from: date)
                    userViewModel.completeTask()
                    pomodoroModel.stopTimer()
                    pomodoroModel.minute = 1
                    userViewModel.addTaskToOneDate(type: "Pomodoro Clock", title: "Break", inputDate: Date(), hour: hour, min: minute, second: second)
                    pomodoroModel.startTimer()
                    pomodoroModel.addNewTimer = true
                    
                    //clickIcon()
                    userViewModel.printTaskMetaData()
                }
            }
            
            Button {
                if pomodoroModel.isStarted {
                    pomodoroModel.isStarted = false
                }
                else {
                    pomodoroModel.isStarted = true
                }
                
            } label: {
                Image(systemName: !pomodoroModel.isStarted ? "play" : "pause")
                //.resizable()
                    .font(.largeTitle.bold())
                    .foregroundColor(.black)
                    .frame(width: 30, height: 20)
                    .background{
                        Circle()
                            .fill(Color("Blue"))
                    }
                    .shadow(color: Color("Blue"), radius: 8, x: 0, y: 0)
            }
             
        }
        
    }
    
    /*
    func clickIcon() {
        /*
         let incrementValue: Float = 1.0 / Float(userViewModel.getTaskNumber())
         self.progressValue += incrementValue
         */
        self.progressValue = Float(userViewModel.getCompletePercentage())
    }
     */
}

struct ProgressBar: View {
    //@Binding var progress: Float
    var color: Color = Color.blue
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        ZStack {
            /*
             Circle()
             .stroke(lineWidth: 12.0)
             .opacity(0.20)
             .foregroundColor(Color.gray)
             */
            Circle()
                .trim(from: 0.0, to: CGFloat(min(userViewModel.todaysTasks.completePercentage, 1.0)))
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
        // let currentTask = Task("Workout",title: "Keto Diet...🍣", startingHour: 8, startingMin: 0, hour: 0, min: 0, second: 10, time: Date())
        CurrentDynamicButtonView()
            .environmentObject(UserViewModel())
            //.preferredColorScheme(.dark)
            .environmentObject(PomodoroModel())
    }
}
