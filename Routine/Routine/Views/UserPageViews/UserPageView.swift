//
//  UserPageView.swift
//  Routine
//
//  Created by Dajun Xian on 10/2/22.
//

import SwiftUI

struct ProfilePicView: View {
    var body: some View {
        Image("me")
            .resizable()
            .frame(width: 300, height: 300)
    }
}

struct UserPageView: View {
    @Binding var name: String
    
    var body: some View {
        ZStack{
            Color(red:225 / 255, green: 225 / 255, blue: 225 / 255)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 7) {
                //My Profile
                HStack {
                    Text("PROFILE")
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding()
                    Spacer()
                    
                    NavigationLink(destination: SettingView()){
                        Image("setting")
                            .resizable()
                            .frame(width: 45, height: 45)
                            .padding(.leading, 4.0)
                    }
                }
                
                NavigationLink(destination: ProfilePicView()){
                    Image("me")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 125)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 5))
                    
                }
                Text(name)
                    .font(.system(size: 30))
                    .foregroundColor(.black)
                Text("Happy life:)")
                    .font(.system(size:18))
                    .foregroundColor(.black)
                NavigationLink(destination: EditPageView()){
                    Text("Edit")
                        .font(.system(size: 14))
                        .foregroundColor(.blue)
                }
                
                List{
                    Text("Points")
                    Text("Calender")
                    Text("Achivements")
                }
                //Spacer()
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
    
    
    
    struct UserPageView_Previews: PreviewProvider {
        static var previews: some View {
            UserPageView(name: .constant("Name"))
        }
    }
}

