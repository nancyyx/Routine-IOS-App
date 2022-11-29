//
//  SwiftUIView.swift
//  Routine
//
//  Created by 张元贞 on 2022/10/14.
//
import SwiftUI
import UIKit

struct EditPageView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @State var name: String
    @State var text: String
    var userPageView: UserPageView?
    
    // @State private var text1 = ""
    @AppStorage("STRING_KEY1") var savedText1 = ""
    @AppStorage("STRING_KEY2") var savedText2 = ""
    
    
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false
    
    var body: some View {
        NavigationView{
            VStack {
                
                
                
                Form {
                    
                    Section(header:  Text("Profile Picture")){
                         HStack(spacing: 60) {
                             Button {
                                 self.sourceType = .photoLibrary
                                 self.isImagePickerDisplay.toggle()
                                 print(self.isImagePickerDisplay)
                             } label : {
                                 
                                 if selectedImage != nil {
                                     Image(uiImage: selectedImage!)
                                         .resizable()
                                         .aspectRatio(contentMode: .fit)
                                         //.frame(width: 200)
                                         .clipShape(Circle())
                                         .overlay(Circle().stroke(Color.white, lineWidth: 5))
                                         .padding()
                                 } else {
                                     if (userViewModel.userAvatar != nil) {
                                         Image(uiImage: userViewModel.userAvatar!)
                                             .resizable()
                                             .aspectRatio(contentMode: .fit)
                                             //.frame(width: 200)
                                             .clipShape(Circle())
                                             .overlay(Circle().stroke(Color.white, lineWidth: 5))
                                             .padding()
                                     } else {
                                         Image("me")
                                             .resizable()
                                             .aspectRatio(contentMode: .fit)
                                             //.frame(width: 200)
                                             .clipShape(Circle())
                                             .overlay(Circle().stroke(Color.white, lineWidth: 5))
                                             .padding()
                                     }
                                 }
                             }
                         }
                         .sheet(isPresented: self.$isImagePickerDisplay) {ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)}
                         
                    }
                    
                   
                    Section(header: Text("User name")){
                        TextField("", text: $name)
                            .padding(.horizontal)
                            .frame(height: 50)
                            .cornerRadius(10)
                            .disableAutocorrection(true)
                    }
                    
                    Section(header: Text("What's on your mind?")){
                        TextField("", text: $text)
                            .padding(.horizontal)
                            .frame(height: 50)
                            .cornerRadius(10)
                            .disableAutocorrection(true)
                    }
                    
                    
                    
                }
            }
            
            .navigationBarTitle("User Info")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        userViewModel.userAvatar = selectedImage
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
                .environmentObject(UserViewModel())
        }
    }
}
