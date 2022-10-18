//
//  SettingView.swift
//  Routine
//
//  Created by Dajun Xian on 10/2/22.
//

import SwiftUI

struct SettingView: View {
    @State var notification = true
    @State var darkMode = false
    @State var isChoicenessSeleted = true
    @State var isInformationSeleted = true

    var body: some View {
        ZStack {
            Color(red: 246 / 255, green: 246 / 255, blue: 246 / 255).edgesIgnoringSafeArea(.all)
            Form {
                Section {
                    /*
                    Toggle(isOn: $notification) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Notifications")
                                .font(.system(size: 17))
                                .foregroundColor(.black)
                        }
                    }
                     */
                    Toggle(isOn: $darkMode) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Dark Mode")
                                .font(.system(size: 17))
                                .foregroundColor(.black)
                        }
                    }
                }
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
