//
//  UserPageView.swift
//  Routine
//
//  Created by Dajun Xian on 10/2/22.
//

import SwiftUI

struct ProfilePicView: View {
    var body: some View{
        Image("me")
            .resizable()
            .frame(width: 300, height: 300)
    }
}

struct UserPageView: View {
    var body: some View {
        NavigationView{
            ZStack{
                Color(red:225 / 255, green: 225 / 255, blue: 225 / 255).edgesIgnoringSafeArea(.all)
                VStack(spacing: 7) {
                    //My Profile
                    NavigationLink(destination: ProfilePicView()){
                        Image("me")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 125)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 5))
                        
                    }
                    Text("Name")
                        .font(.system(size: 30))
                        .foregroundColor(.black)
                    Text("Happy life:)")
                        .font(.system(size:18))
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
