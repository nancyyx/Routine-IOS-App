//
//  SwiftUIView.swift
//  Routine
//
//  Created by 张元贞 on 2022/10/14.
//

import SwiftUI

struct EditPageView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @State var name: String
    @State var text: String
    var userPageView: UserPageView?
    
   // @State private var text1 = ""
    @AppStorage("STRING_KEY1") var savedText1 = ""
    @AppStorage("STRING_KEY2") var savedText2 = ""
    
    var body: some View {
        NavigationView{
            VStack {
                Form {
                    Section(header: Text("User name")){
                        TextField("", text: $name)
                            .padding(.horizontal)
                            .frame(height: 50)
                            .background(Color.white)
                            .cornerRadius(10)
                            .disableAutocorrection(true)
                    }
                    
                    Section(header: Text("What's on your mind?")){
                        TextField("", text: $text)
                            .padding(.horizontal)
                            .frame(height: 50)
                            .background(Color.white)
                            .cornerRadius(10)
                    }
                    
                }
            }
            .navigationBarTitle("User Info")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        userViewModel.setInfo(name: name, wasup: text)
                        userPageView?.presentEdit = false
                    }, label: {
                        Text("Complete")
                    })
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        userPageView?.presentEdit = false
                    }, label: {
                        Text("Cancel")
                    })
                }
                
            }
        }
        
    }
    
    struct EditPageView_Previews: PreviewProvider {
        static var previews: some View {
            EditPageView(name: "", text: "")
        }
    }
}
