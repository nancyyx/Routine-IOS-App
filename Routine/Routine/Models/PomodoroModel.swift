//
//  PomodoroModel.swift
//  Routine
//
//  Created by Nancy  Ma on 10/10/22.
//

import SwiftUI

class PomodoroModel: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    @Published var progress: CGFloat = 1
    @Published var isStarted: Bool = false
    @Published var isFinished: Bool = false
    @Published var addNewTimer: Bool = false
    
    @Published var hour: Int = 0
    @Published var minute: Int = 0
    @Published var second: Int = 0
    @Published var totalSeconds: Int = 0
    @Published var staticTotalSeconds: Int = 0
    
    override init() {
        super.init()
    }
    
    func authorizeNotification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.sound,.badge,.alert]){
            _, _ in
        }
        UNUserNotificationCenter.current().delegate = self
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping(UNNotificationPresentationOptions)->Void){
        completionHandler([.sound,.banner])
    }
    
    
    func startTimer(){
        withAnimation(.easeInOut(duration: 0.25)){
            isStarted = true
        }
        totalSeconds = (hour * 3600) + (minute * 60) + second
        staticTotalSeconds = totalSeconds
        addNewTimer = false
        addNotification()
    }
    
    func stopTimer() {
        withAnimation{
            isStarted = false
            hour = 0
            minute = 0
            second = 0
            progress = 1
        }
        totalSeconds = 0
        staticTotalSeconds = 0
    }
    
    func updateTimer(){
        totalSeconds -= 1
        progress = CGFloat(totalSeconds) / CGFloat(staticTotalSeconds)
        print(staticTotalSeconds)
        progress = (progress < 0 ? 0 : progress)
        hour = totalSeconds / 3600
        minute = (totalSeconds / 60) % 60
        second = (totalSeconds % 60)
        if totalSeconds <= 0 {
            isStarted = false
            print("Finished")
            isFinished = true
        }
    }
    
    func addNotification(){
        let content = UNMutableNotificationContent()
        content.title = "Routine"
        content.subtitle = "Congrats!!!"
        content.sound = UNNotificationSound.default
        print(staticTotalSeconds)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(staticTotalSeconds), repeats: false))
        UNUserNotificationCenter.current().add(request)
    }
}
