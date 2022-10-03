//
//  addViews.swift
//  Routine
//
//  Created by Dajun Xian on 10/2/22.
//

import SwiftUI

struct AddView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @State  var textFieldDescription: String
    @State  var textFieldTitle: String
    var tabBarview: CustomTabView?
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Task Info")) {
                        TextField("Title", text: $textFieldTitle)
                            .padding(.horizontal)
                            .frame(height: 50)
                            .background(Color.white)
                            .cornerRadius(10)
                        TextField("Description", text: $textFieldDescription)
                            .padding(.horizontal)
                            .font(.headline)
                            .frame(height: 50)
                            .background(Color.white)
                            .cornerRadius(10)
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
        userViewModel.addNewTask(title: textFieldTitle, description: textFieldDescription)
        userViewModel.incrementTaskNumber()
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
        AddView(textFieldDescription: "", textFieldTitle: "")
            .environmentObject(UserViewModel())
    }
        
}

