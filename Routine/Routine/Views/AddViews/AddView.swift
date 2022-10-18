//
//  addViews.swift
//  Routine
//
//  Created by Dajun Xian on 10/2/22.
//

import SwiftUI

struct AddView: View {
    @EnvironmentObject var userViewModel: UserViewModel
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
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Task Info")) {
                        TextField("Task Type", text: $textFieldType)
                            .padding(.horizontal)
                            .frame(height: 50)
                            .background(Color.white)
                            .cornerRadius(10)
                        TextField("Description", text: $textFieldTitle)
                            .padding(.horizontal)
                            .font(.headline)
                            .frame(height: 50)
                            .background(Color.white)
                            .cornerRadius(10)
                    }
                    
                    Section(header: Text("Timing Info")) {
                        VStack {
                            DatePicker("Start: ", selection: $startingDate, in: Date()...)
                            DatePicker("End: ", selection: $endingDate, in: Date()...)
                            //DatePicker("Duration: ", selection: $durationDate, displayedComponents: [.hourAndMinute])
                        }
                    }
                    
                    Section(header: Text("Duration")) {
                        HStack {
                            Picker(selection: self.$durationHour, label: Text("")){
                                ForEach(0 ..< 24) { index in
                                    Text("\(self.selectHour[index]) h").tag(index)
                                }
                            }
                            .frame(width: 70, height: 100, alignment: .center)
                            .pickerStyle(.wheel)
                            
                            Picker(selection: self.$durationMin, label: Text("")){
                                ForEach(0 ..< 60) { index in
                                    Text("\(self.selectMin[index]) m").tag(index)
                                }
                            }
                            .frame(width: 70, height: 100, alignment: .center)
                            .pickerStyle(.wheel)
                            
                            Picker(selection: self.$durationSec, label: Text("")){
                                ForEach(0 ..< 60) { index in
                                    Text("\(self.selectSec[index]) s").tag(index)
                                }
                            }
                            .frame(width: 70, height: 100, alignment: .center)
                            .pickerStyle(.wheel)
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
            var dateComponents = calender.dateComponents([.year, .month, .day], from: self)
            return calender.date(from: dateComponents)
        }
    }

}

