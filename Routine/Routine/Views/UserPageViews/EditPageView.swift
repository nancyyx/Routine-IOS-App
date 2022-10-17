//
//  SwiftUIView.swift
//  Routine
//
//  Created by 张元贞 on 2022/10/14.
//

import SwiftUI

struct EditPageView: View {
    @State var name: String = "Name"
    @State var text: String = "Happy life:)"
    var body: some View {
        Form {
            Section {
                VStack(alignment: .leading, spacing: 7) {
                    Text("Profile Picture")
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                    Image("me")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 125)
                        .clipShape(Circle())
                        //.overlay(Circle().stroke(Color.white, lineWidth: 5))
                }
                
                VStack(spacing: 7) {
                 HStack{
                    Text("Name： ")
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                    TextEditor(text: $name)
                        .font(.system(size: 20))
                        .foregroundColor(.gray)
                    }
                }
                
                VStack(spacing: 7) {
                    HStack {
                        Text("What's Up")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                        TextEditor(text: $text)
                            .font(.system(size:20))
                            .foregroundColor(.gray)
                    }
                }
            }
        }
    }
    
    struct EditPageView_Previews: PreviewProvider {
        static var previews: some View {
            EditPageView()
        }
    }
}
