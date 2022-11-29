//
//  addViews.swift
//  Routine
//
//  Created by Dajun Xian on 10/2/22.
//

import SwiftUI
/*
enum TaskTypes: String, CaseIterable, Identifiable {
    case Workout
    case Drink
    case Smile
    case Read
    
    var id: Self { self }
}
 

enum Catergory: String, CaseIterable, Identifiable {
    case General
    case SelfImprovement
    case Housework
    case Health
    case Economics
    
    var id: Self { self }
}
 */

enum DefaultType: String, CaseIterable, Identifiable {
    case General
    var id: Self { self }
}

enum Economics: String, CaseIterable, Identifiable {
    case Pay
    case Stock
    var id: Self { self }
}

enum Health: String, CaseIterable, Identifiable {
    case Dining
    case Drink
    case Sleep
    case Workout
    case Hospital
    
    var id: Self { self }
}

enum Housework: String, CaseIterable, Identifiable {
    case Clean
    case Laundry
    
    var id: Self { self }
}

enum SelfImprovement: String, CaseIterable, Identifiable {
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
    @State var textFieldTitle = "Description of the task."
    @State var startingDate = Date()
    @State var endingDate = Date()
    @State var durationDate = Date()
    @State var durationHour = 0
    @State var durationMin = 0
    @State var durationSec = 10
    @State var selectedCatergoryIndex = 0
    
    @ObservedObject var taskTypeModel = TaskTypeModel()
    
    var selectHour = [Int](0..<24)
    var selectMin = [Int](0..<60)
    var selectSec = [Int](0..<60)
    
    var catergory = ["Default", "SelfImprovement", "Housework", "Health", "Economics"]
    //var taskDurationRange = Calendar.current.date(byAdding: .hour, value: , to: Date())!
    var tabBarview: CustomTabView?
    
    //let days: [String] = ["Workout","Drink","Smile","Read"]
    

    
    @State private var selectedType: String = DefaultType.General.rawValue

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
                            Picker("Task Type ", selection: $taskTypeModel.selectedTaskType content: {
                                ForEach(0..<catergory.count,  content: { index in
                                    Text(catergory[index])
                                    
                                })
                            })
                             */
                            Picker(selection: $taskTypeModel.selectedTaskType, label: Text("Type")){
                                ForEach(0 ..< taskTypeModel.taskTypeNames.count){ index in
                                    Text(self.taskTypeModel.taskTypeNames[index])
                                }
                            }
                            
                            
                            ScrollView(.horizontal) {
                                LazyHStack {
                                    ForEach( 0 ..< taskTypeModel.taskOfTypeNamesCount) { ts in
                                        Button {
                                            self.taskTypeModel.selectedTaskOfType = ts
                                            selectedType = self.taskTypeModel.taskOfTypeNames[ts]
                                        } label: {
                                            Circle()
                                                .stroke(lineWidth: 3)
                                                .shadow(color: taskTypeModel.selectedTaskOfType == ts ?  Color.white : Color.clear, radius: 2)
                                                .foregroundColor(taskTypeModel.selectedTaskOfType == ts ?  (colorScheme == .dark ? Color.white : Color.blue) : Color.black.opacity(0.1))
                                                .frame(width: 35, height: 35.0)
                                                .overlay(
                                                    Image(taskTypeModel.taskOfTypeNames[ts])
                                                        .resizable()
                                                        .renderingMode(.template)
                                                        .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                                                        .frame(width: 30, height: 30)
                                                        .clipShape(Circle())
                                                
                                                )
                                        }
                                        .padding(3.0)
                                        
                                    }
                                    .id(taskTypeModel.id)
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

