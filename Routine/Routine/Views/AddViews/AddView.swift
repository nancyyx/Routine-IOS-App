//
//  addViews.swift
//  Routine
//
//  Created by Dajun Xian on 10/2/22.
//

import SwiftUI
enum TaskTypes: String, CaseIterable, Identifiable {
    case Workout
    case Drink
    case Smile
    case Read
    
    var id: Self { self }
}

struct AddView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var todaysTasks: TaskMetaData
    @Environment(\.colorScheme) var colorScheme
    //@State var textFieldType: String
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
    
    //let days: [String] = ["Workout","Drink","Smile","Read"]
    

    
    @State private var selectedType: String = TaskTypes.Workout.rawValue.capitalized

    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack {
                        
                    
                        
                    
                    
                     
                    
                    /*
                    Picker("Type", selection: $selectedType) {
                        ForEach(TaskTypes.allCases) { task in
                            Image(task.rawValue.capitalized)
                                .resizable()
                                .foregroundColor(Color.white)
                                .frame(width: 30, height: 30)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Picker("Type", selection: $selectedType) {
                        ForEach(TaskTypes.allCases) { task in
                            
                        }
                    }*/
                    Form {
                        
                        
                        
                        Section(header: Text("Task Info")) {
                            
                            
                            
                            /*
                            TextField("Task Type", text: $textFieldType)
                                .padding(.horizontal)
                                .frame(height: 30)
                                .cornerRadius(10)
                             */
                            
                            ScrollView(.horizontal) {
                                LazyHStack {
                                    
                                    ForEach(TaskTypes.allCases) { ts in
                                        Button {
                                            selectedType = ts.rawValue.capitalized
                                        } label: {
                                            Circle()
                                                .stroke(lineWidth: 3)
                                                .shadow(color: selectedType == ts.rawValue.capitalized ?  Color.white : Color.clear, radius: 2)
                                                .foregroundColor(selectedType == ts.rawValue.capitalized ?  (colorScheme == .dark ? Color.white : Color.blue) : Color.black.opacity(0.1))
                                                .frame(width: 35, height: 35.0)
                                                .overlay(
                                                    Image(ts.rawValue.capitalized)
                                                        .resizable()
                                                        .renderingMode(.template)
                                                        .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                                                        .frame(width: 30, height: 30)
                                                        .clipShape(Circle())
                                                
                                                )
                                        }
                                        .padding(3.0)
                                        
                                    }
                                }
                            }
                            .frame(height: 40, alignment: .center)
                            .padding()
                            
                            TextField("Description", text: $textFieldTitle)
                                .padding(.horizontal)
                                .font(.body)
                                .frame(height: 30)
                                .cornerRadius(10)
                                .disableAutocorrection(true)
                        }
                        
                        Section(header: Text("Timing Info")) {
                            VStack {
                                
                                DatePicker("Starts ", selection: $startingDate, in: Date()...)
                                DatePicker("End Date ", selection: $endingDate, in: Date()..., displayedComponents: [.date])
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
        for date in stride(from: startingDate, to: endingDate.addingTimeInterval(3600), by: dayDurationInSeconds) {
            userViewModel.addTaskToOneDate(
                type: selectedType,
                title: textFieldTitle,
                inputDate: date,
                hour: durationHour,
                min: durationMin,
                second: durationSec)
            
        }
       // userViewModel.printTaskMetaData()
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
        let currentTask = Task("Workout",title: "Keto Diet...🍣", startingHour: 8, startingMin: 0, hour: 0, min: 0, second: 10, time: Date())
        
        AddView( textFieldTitle: "foo")
            .environmentObject(UserViewModel())
            .environmentObject(TaskMetaData(tasks: [currentTask], taskDate: Date()))
    }
        
}


extension UIPickerView {   open override var intrinsicContentSize: CGSize {     return CGSize(width: UIView.noIntrinsicMetric, height: super.intrinsicContentSize.height)   } }

