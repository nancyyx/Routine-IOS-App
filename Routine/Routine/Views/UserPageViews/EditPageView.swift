//
//  SwiftUIView.swift
//  Routine
//
//  Created by 张元贞 on 2022/10/14.
//

import SwiftUI

struct EditPageView: View {
    @State var name: String = ""
    @State var text: String = ""
    
   // @State private var text1 = ""
    @AppStorage("STRING_KEY1") var savedText1 = ""
    @AppStorage("STRING_KEY2") var savedText2 = ""
    
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
                }
                
                VStack(spacing: 7) {
                 HStack{
                     Text("Name: ")
                         .font(.system(size: 20))
                         .foregroundColor(.black)
                     TextField("Type your new name here ", text: $name)
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                        .disableAutocorrection(true)
                        .onChange(of: name) { name in
                            self.savedText1 = name
                        }
                        .onAppear {
                            self.name = savedText1
                            name = self.name
                        }
                    }
                }
                
                VStack(spacing: 7) {
                    HStack {
                        Text("What's Up: ")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                        TextField("Type your thoughs here ", text: $text)
                           .font(.system(size: 20))
                           .foregroundColor(.black)
                           .disableAutocorrection(true)
                           .onChange(of: text) { text in
                               self.savedText2 = text
                           }
                           .onAppear {
                               self.text = savedText2
                               text = self.text
                           }
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
