//
//  addViews.swift
//  Routine
//
//  Created by Dajun Xian on 10/2/22.
//

import SwiftUI

struct AddView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var todaysTasks: TaskMetaData
    @State var textFieldType: String
    @State var textFieldTitle: String
    @State var startingDate = Date()
    @State var endingDate = Date()
    @State var durationDate = Date()
    @State var durationHour = 0
    @State var durationMin = 0
    @State var durationSec = 10
    
    var selectHour = [Int](0..<24)
    var selectMin = [Int](0..<60)
    var selectSec = [Int](0..<60)
    
    //var taskDurationRange = Calendar.current.date(byAdding: .hour, value: , to: Date())!
    var tabBarview: CustomTabView?
    
    let days: [String] = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack {
                    Form {
                        Section(header: Text("Task Info")) {
                            TextField("Task Type", text: $textFieldType)
                                .padding(.horizontal)
                                .frame(height: 30)
                                .background(Color.white)
                                .cornerRadius(10)
                            TextField("Description", text: $textFieldTitle)
                                .padding(.horizontal)
                                .font(.headline)
                                .frame(height: 30)
                                .background(Color.white)
                                .cornerRadius(10)
                        }
                        
                        Section(header: Text("Timing Info")) {
                            VStack {
                                
                                DatePicker("Starts ", selection: $startingDate, in: Date()...)
                                DatePicker("Ends ", selection: $endingDate, in: Date()..., displayedComponents: [.date])
                                //DatePicker("Duration: ", selection: $durationDate, displayedComponents: [.hourAndMinute])
                            }
                        }
                        
                        Section(header: Text("Duration")) {
                            HStack (spacing: 0){
                                Picker(selection: self.$durationHour, label: Text("")){
                                    ForEach(0 ..< 24) { index in
                                        Text("\(self.selectHour[index]) h").tag(index)
                                    }
                                }
                                .pickerStyle(.wheel)
                                .frame(height: 100)
                                .clipped()
                                //.compositingGroup()
                                
                                Picker(selection: self.$durationMin, label: Text("")){
                                    ForEach(0 ..< 60) { index in
                                        Text("\(self.selectMin[index]) m").tag(index)
                                    }
                                }
                                .pickerStyle(.wheel)
                                .frame(height: 100)
                                .clipped()
                                //.compositingGroup()
                                
                                
                                Picker(selection: self.$durationSec, label: Text("?")){
                                    ForEach(0 ..< 60) { index in
                                        Text("\(self.selectSec[index]) s").tag(index)
                                    }
                                }
                                .pickerStyle(.wheel)
                                .frame(height: 100)
                                .clipped()
                                //.compositingGroup()
                                
                                //Spacer()
                            }

                        }
                    }
                }
                .navigationBarTitle("Add Task")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            clickAdd()
                            tabBarview?.presentSheet = false
                        }, label: {
                            Text("Add")
                        })
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            tabBarview?.presentSheet = false
                        }, label: {
                            Text("Cancel")
                        })
                    }
                    
                }

            }
        }
    }
    /*
    func clickAdd() {
        
        userViewModel.addTaskToOneDate(
            type: textFieldType,
            title: textFieldTitle,
            inputDate: startingDate,
            hour: durationHour,
            min: durationMin,
            second: durationSec)
        userViewModel.printTaskMetaData()
    }
    */
    func clickAdd() {
        let dayDurationInSeconds: TimeInterval = 60*60*24
        for date in stride(from: startingDate, to: endingDate, by: dayDurationInSeconds) {
            userViewModel.addTaskToOneDate(
                type: textFieldType,
                title: textFieldTitle,
                inputDate: date,
                hour: durationHour,
                min: durationMin,
                second: durationSec)
            
        }
        userViewModel.printTaskMetaData()
    }
    
    /*
    var body: some View {
        NavigationView{
            Spacer()
            VStack {
                TextField("Title", text: $title)
                    .padding(.horizontal)
                    .frame(height: 50)
                    .background(Color.white)
                    .cornerRadius(10)
                TextField("Description", text: $description)
                    .padding(.horizontal)
                    .font(.headline)
                    .frame(height: 50)
                    .background(Color.white)
                    .cornerRadius(10)
            }
            Spacer()
            /*
            VStack {
                Form {
                    Section(header: Text("Task Info")) {
                        TextField("Title", text: $title)
                            .padding(.horizontal)
                            .frame(height: 50)
                            .background(Color.white)
                            .cornerRadius(10)
                        TextField("Description", text: $description)
                            .padding(.horizontal)
                            .font(.headline)
                            .frame(height: 50)
                            .background(Color.white)
                            .cornerRadius(10)
                    }
                }
            }
             */
        }
        .navigationTitle("Add a task")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    
                }, label: {
                    Text("Add")
                })
            }
        }

    
    }
     */
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(textFieldType: "", textFieldTitle: "")
            .environmentObject(UserViewModel())
    }
        
}

extension Date {

    var onlyDate: Date? {
        get {
            let calender = Calendar.current
            let dateComponents = calender.dateComponents([.year, .month, .day], from: self)
            return calender.date(from: dateComponents)
        }
    }

}

extension Date: Strideable {
    public func distance(to other: Date) -> TimeInterval {
        return other.timeIntervalSinceReferenceDate - self.timeIntervalSinceReferenceDate
    }

    public func advanced(by n: TimeInterval) -> Date {
        return self + n
    }
}


extension UIPickerView {   open override var intrinsicContentSize: CGSize {     return CGSize(width: UIView.noIntrinsicMetric, height: super.intrinsicContentSize.height)   } }

