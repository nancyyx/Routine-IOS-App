//
//  addViews.swift
//  Routine
//
//  Created by Dajun Xian on 10/2/22.
//

import SwiftUI

struct AddView: View {
    @State  var description: String
    @State  var title: String
    var tabBarview: CustomTabView?
    var body: some View {
        NavigationView {
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
            .navigationBarTitle("Add Task")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        
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
        AddView(description: "", title : "")
    }
}

