//
//  TabBarView.swift
//  Routine
//
//  Created by Dajun Xian on 10/1/22.
//

import SwiftUI

enum Tab {
    case first
    case second
}

struct TabBarView: View {
    @State private var selectedTab: Tab = .first
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack (spacing: 0){
            VStack(spacing: 0) {
                switch selectedTab {
                case .first:
                    HomeView()
                        //.ignoresSafeArea()
                case .second:
                    UserPageView()
                        //.ignoresSafeArea()
                }
                   
                
            }
            .padding(.top, 60)
            .background(colorScheme == .dark ? Color.black : Color.gray.opacity(0.03))

            Divider()
            CustomTabView(selectedTab: $selectedTab)
                
        }
        
        .ignoresSafeArea()
    }
}

struct CustomButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .shadow(
                color: configuration.isPressed ?
                (colorScheme == .dark ? Color.white : Color.gray.opacity(0.5)) : Color.clear,
                radius: 4, x: 0, y: 0
            )
    }
}

struct CustomTabView: View {
    @Binding var selectedTab : Tab
    @State var presentSheet = false
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            
            Button {
                selectedTab = .first
            } label: {
                Image(systemName: "house")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundColor(selectedTab == .first ? .blue : .primary)
            }
            
            Spacer()
            
            Button {
                print("add")
                presentSheet = true
            } label: {
                ZStack {
                    Circle()
                        //.stroke(lineWidth: 3)
                        .foregroundColor(.white)
                    
                        .frame(width: 60, height: 60)
                        .shadow(color: colorScheme == .dark ? Color.white : Color.gray.opacity(0.5), radius: 3)
                    
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(colorScheme == .dark ? Color.black : Color.blue)
                        .frame(maxWidth: 55, maxHeight: 55, alignment: .center)
                    .aspectRatio(contentMode: .fit)
                }
                .offset(y: -15)
            }
            .buttonStyle(CustomButtonStyle())
            .sheet(isPresented: $presentSheet) {
                AddView(textFieldTitle: "", tabBarview: self)
            }
            
            Spacer()
            
            Button {
                selectedTab = .second
            } label: {
                Image(systemName: "person")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundColor(selectedTab == .second ? .blue : .primary)
            }
            
            
            Spacer()
        }
        .padding(.bottom, 15.0)
        
    }
}
    
    
    
    
    
    
    /*
    var body: some View {
        
        NavigationView {
            ZStack {
                TabView {
                    HomeView()
                        .tabItem {
                            Image(systemName: "house")
                        }
                    
                    Button {
                        print("add")
                        presentSheet = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50, alignment: .center)
                            .aspectRatio(contentMode: .fit)
                    }
                    .padding()
                    .sheet(isPresented: $presentSheet) {
                        Text("Detail")
                    }
                    
                    Text("Myself")
                        .tabItem {
                            Image(systemName: "person")
                        }
                }
                
                //.statusBar(hidden: true)
                /*
                VStack {
                    Spacer()
                    Button {
                        print("add")
                        presentSheet = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50, alignment: .center)
                            .aspectRatio(contentMode: .fit)
                    }
                    .padding()
                    .sheet(isPresented: $presentSheet) {
                        Text("Detail")
                    }
                }
                 */
                //.statusBar(hidden: true)

            }
            
        }

        .navigationBarHidden(true)
        
        
       
    }
    
}
     */

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
            .environmentObject(UserViewModel())
    }
}
