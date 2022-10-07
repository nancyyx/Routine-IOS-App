//
//  UserPageView.swift
//  Routine
//
//  Created by Dajun Xian on 10/2/22.
//

import SwiftUI

struct ProfilePicView: View {
    var body: some View{
        Text("Hello")
    }
}

struct UserPageView: View {
    var body: some View {
        NavigationView{
            ZStack{
                Color(red:240 / 255, green: 240 / 255, blue: 240 / 255).edgesIgnoringSafeArea(.all)
                VStack(spacing: 20) {
                    NavigationLink(destination: ProfilePicView()){
                        Image("me")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 5))
                        
                    }
                    Text("Name")
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                    Text("Edit")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    NavigationView{
                        List{
                            Text("Points")
                            Text("Calender")
                            Text("Achivements")
                        }
                    }
                }.padding(.top, 40)
            }
        }.navigationBarTitle("My Profile", displayMode: .inline)
    }
    
    
    struct UserPageView_Previews: PreviewProvider {
        static var previews: some View {
            UserPageView()
        }
    }
}
