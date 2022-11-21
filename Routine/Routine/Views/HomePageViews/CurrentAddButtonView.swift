//
//  CurrentAddButtonView.swift
//  Routine
//
//  Created by Dajun Xian on 10/3/22.
//

import SwiftUI

struct CurrentAddButtonView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    //@State var presentSheet = false
    //let currentTask: TaskModel
    var body: some View {
        ZStack {
            outerCircle()
            
                
        }
        .scaledToFit()
       
    }
 
    
}


struct outerCircle: View {
    @State var whiteOpacity = 0.7
    @State var stateValue = 1.0
    @State var rotate = -1
    @State var degree = 30
    @State var rotate2 = 5
    @State var degree2 = 150
    @State var presentSheet = false
    @State var t = 0.0
    @Environment(\.colorScheme) var colorScheme
    
    
    //@State var show = false
    let timer = Timer.publish(every: 0.2, on: .main, in:
            .common).autoconnect()
    var body: some View {
        ZStack {
            /*
            Circle()
                .clipShape(Circle())
                .frame(width: 100, height: 100)
                .foregroundColor(Color.white)
                .shadow(color: Color.white, radius: 10)
            */
            
            
            Circle()
                .frame(width: 100, height: 100)
                .foregroundColor( colorScheme == .dark ? Color.black : Color.clear)
                //.shadow(color: colorScheme == .dark ? Color.white.opacity(whiteOpacity*5) : Color.clear, radius:  whiteOpacity*30)
                .shadow(color: colorScheme == .dark ? Color.white.opacity(0.7) : Color.clear, radius: 8 + 5 * sin(t), x: sin(t)*2, y: -sin(2*t)*2)
                .overlay(
                    Button {
                        presentSheet = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .scaledToFit()
                            .foregroundColor(colorScheme == .dark ? Color.black : Color.blue.opacity(whiteOpacity+0.8))
                            //.colorInvert()
                        /*
                            .overlay(
                                Circle()
                                    .fill(LinearGradient(gradient: .init(colors: [colorScheme == .dark ? Color.white : Color.white, .clear, colorScheme == .dark ? Color.white.opacity(0.8) : Color.white.opacity(0.9)]), startPoint: .top, endPoint: .bottom))
                                    .rotationEffect(Angle(degrees: Double(degree)))
                                
                            )*/
                    }.sheet(isPresented: $presentSheet) {
                        AddView(textFieldTitle: "")
                    }
                    
                )
            
            Circle()
                .stroke(Color.gray.opacity(0.2), style: StrokeStyle(lineWidth: 23, lineCap: .round, lineJoin: .round))
                .frame(maxWidth: 180)
                .padding()
                //.shadow(color: colorScheme == .dark ? Color.white.opacity(0.1) : Color.clear, radius: whiteOpacity*15)
            
            Circle()
                .stroke(lineWidth: 23)
                .opacity(0.20)
                .foregroundColor(Color.gray)
                .frame(maxWidth: 250, maxHeight: 250)
                
            //colorScheme == .dark ? Color.white : Color.white.opacity(0.8)
            //colorScheme == .dark ? Color.white : Color.white
        //colorScheme == .dark ? Color.white : Color.white.opacity(whiteOpacity)
            //colorScheme == .dark ? Color.white : Color.white.opacity(whiteOpacity+0.2)
            Circle()
                .stroke(colorScheme == .dark ? Color.white.opacity(whiteOpacity) : Color.blue.opacity(whiteOpacity), style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                .overlay(
                    Circle()
                        .stroke(lineWidth: 12.0)
                        .fill(LinearGradient(gradient: .init(colors: [colorScheme == .dark ? Color.white.opacity(whiteOpacity-0.3) : Color.blue.opacity(whiteOpacity-0.4), .clear, colorScheme == .dark ? Color.white.opacity(0.5) : Color.blue.opacity(0.1)]), startPoint: .top, endPoint: .bottom))
                        .rotationEffect(Angle(degrees: Double(degree)))
                        .shadow(color: colorScheme == .dark ? Color.white.opacity(0.7) : Color.clear, radius: whiteOpacity*10, x: Double(-rotate)*whiteOpacity*10, y: Double(rotate) * whiteOpacity*10)
                        //.offset(x: self.show ? -90 : 270)
                        
                )
                .overlay(
                    Circle()
                        .stroke(lineWidth: 12.0)
                        .fill(LinearGradient(gradient: .init(colors: [colorScheme == .dark ? Color.white.opacity(0.4) : Color.blue.opacity(0.3), colorScheme == .dark ? Color.clear : Color.blue.opacity(0.3), colorScheme == .dark ? Color.white.opacity(whiteOpacity+0.2) : Color.blue.opacity(whiteOpacity+0.2)]), startPoint: .top, endPoint: .bottom))
                        .rotationEffect(Angle(degrees: Double(degree2)))
                        .shadow(color: colorScheme == .dark ? Color.white.opacity(0.7) : Color.clear, radius: whiteOpacity*10, x: whiteOpacity*10, y: Double(-rotate) * whiteOpacity*10)
                    
                    
                        
                )
                .shadow(color: colorScheme == .dark ? Color.white.opacity(0.2) : Color.clear, radius: 5 + whiteOpacity*10)
                .frame(maxWidth: 250, maxHeight: 250)
                .animation(Animation.default, value: whiteOpacity)
                .onReceive(timer) { _ in
                    /*
                    if (whiteOpacity <= 0.5 || whiteOpacity >= 1.0) {
                        stateValue = stateValue * -1
                    }
                     
                     
                     @State var whiteOpacity = 0.75
                     @State var stateValue = -1
                     @State var rotate = -1
                     @State var degree = 31
                     @State var rotate2 = 1
                     @State var degree2 = 150
                     
                     */
                    
                    /*
                     
                     x        x         x
                     30 + + + 45 - - - 60
                     
                    dark    45 brightest  dark
                     
                     30 0
                     45 3 3 3
                     60 0 0
                     
                     change light
                     ___________
                     31
                     165
                     0.565
                     ___________
                     ___________
                     45
                     345
                     0.07499999999999968
                     change light
                     ___________
                     ___________
                     60
                     120
                     0.6
                     change light
                     ___________
                     */
                    
                    if (degree == 30 || degree == 60) {
                        rotate = rotate * -1
                    }
                    
                    if (degree == 30 || degree == 45 || degree == 60) {
                        stateValue = stateValue * -1
                        print("change light")
                    }
                    
                    if (degree2 <= 130 || degree2 >= 350) {
                        rotate2 = rotate2 * -1
                        
                    }
                    
                    whiteOpacity += 0.035 * stateValue
                    degree += 1 * rotate
                    degree2 += 2 * rotate2
                    t += 0.15
                    print("___________")
                    print(degree)
                    print(degree2)
                    print(whiteOpacity)
                    
                    
                    
                }
                
            
            
            
            
        }
    }
}

extension View {
   @ViewBuilder
   func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> some View {
        if conditional {
            content(self)
        } else {
            self
        }
    }
}

struct CurrentAddButtonView_Previews: PreviewProvider {
    static var previews: some View {
        //let currentTask = TaskModel("Workout", description: "Today is leg day")
        CurrentAddButtonView()
    }
}
