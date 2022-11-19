//
//  CircleAnimation.swift
//  Routine
//
//  Created by Dajun Xian on 11/15/22.
//

import SwiftUI

struct CircleAnimation: View {
    @Environment(\.colorScheme) var colorScheme
    let timer = Timer.publish(every: 0.02, on: .main, in:
            .common).autoconnect()
    /*
     20 * 0.1 = 2s
     360 / 2s
     */
    
    
    @State var shadowFirstPhase = false
    
    @State var circlePerimeter = 0.0
    
    @State var shadowRadius = 1.0
    @State var shadowIncreaseRate = 1.5
    let maxShadowRadius = 23.0

    @State var lineWidthIndex = 0.0
    

    let c1TrimRate = 0.006
    let c2TrimRate = 0.006
    
    
    @State var c1RotateSpeed = 3.0
    @State var c2RotateSpeed = 5.5
    let c1RotateRate = 0.03
    let c2RotateRate = 0.07
    
    /*
     c2SizeRate, scaling speed rate for c2:
     
     (c1EndSize - c1StartSize) / c1SizeRate =
     (c2StartSize - c2EndSize) / c2SizeRate
     
     x = 0.0345
     */
    
    @State var c1StartSize = 0.2
    @State var c2StartSize = 2.0
    let c1StartConst = 0.2
    let c2StartConst = 2.0
    let c1EndSize = 0.6
    let c2EndSize = 0.7
    let c1SizeRate = 0.004
    let c2SizeRate = 0.013

    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0.0, to: circlePerimeter)
                .stroke(style: StrokeStyle(lineWidth: 15 * lineWidthIndex, lineCap: .round, lineJoin: .round))
                //.fill(LinearGradient(gradient: .init(colors: [Color.white , Color.blue.opacity(circlePerimeter+1)]), startPoint: .bottom, endPoint: .top))
                .fill(Color.white)
                .rotationEffect(Angle(degrees: Double( c1RotateSpeed * 360 )))
                .scaleEffect(c1StartSize)
                .shadow(color: Color.white, radius: shadowRadius)
                //.rotationEffect(Angle(degrees: rotateAngle))
                .overlay(
                    Circle()
                        .frame(width: 140, height: 140)
                        .foregroundColor(shadowFirstPhase ? Color.black : Color.clear)
                        .shadow(color: Color.white, radius: shadowRadius/7)
                        .overlay(
                            Image("routineIcon")
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: 125, height: 125)
                                //.clipShape(Circle())
                                .scaledToFit()
                            
                                .foregroundColor(shadowFirstPhase ? Color.white : Color.clear)
                                .shadow(color: Color.white, radius: shadowRadius/23)
                            /*
                            HStack(spacing: 0) {
                                Text("R")
                                    .font(.title)
                                    .fontWeight(.semibold)
                                    .foregroundColor(shadowFirstPhase ? Color.white : Color.clear)
                                    .shadow(color: Color.white, radius: shadowRadius)
                                
                                
                                Text("ou")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundColor(shadowFirstPhase ? Color.white : Color.clear)
                                    .shadow(color: Color.white, radius: shadowRadius)
                                
                                Text("T")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundColor(shadowFirstPhase ? Color.white : Color.clear)
                                    .shadow(color: Color.white, radius: shadowRadius)
                                
                                Text("ine")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundColor(shadowFirstPhase ? Color.white : Color.clear)
                                    .shadow(color: Color.white, radius: shadowRadius)
                                
                            }
                             */
                        )
                   
                )
                .animation(Animation.default, value: c1RotateSpeed)
                .onReceive(timer) { _ in

                    if (lineWidthIndex < 1) {
                        lineWidthIndex += 0.01
                    }
                    
                    if (c1RotateSpeed > 0) {
                        c1RotateSpeed -= c1RotateRate
                    }
                    
                    if (c1StartSize < c1EndSize) {
                        c1StartSize += c1SizeRate
                    }
                    
                    if (circlePerimeter >= 1) {
                        shadowRadius += shadowIncreaseRate
                        
                        if (shadowRadius >= maxShadowRadius) {
                            shadowRadius = maxShadowRadius
                            shadowIncreaseRate = shadowIncreaseRate * -0.1
                            if (shadowFirstPhase){
                                shadowIncreaseRate = 0
                            }
                        }
                        
                        if (shadowRadius < 0) {
                            shadowFirstPhase = true
                            shadowIncreaseRate = shadowIncreaseRate * -3
                        }
                    } else {
                        circlePerimeter += c1TrimRate
                    }
                    
                    print("--------------------")
                    print(circlePerimeter)
                    print(shadowRadius)
                    print(c1RotateSpeed)
                    
                }
                
            Circle()
                .trim(from: 0.0, to: circlePerimeter)
                .stroke(style: StrokeStyle(lineWidth: 20 * lineWidthIndex, lineCap: .round, lineJoin: .round))
                //.fill(LinearGradient(gradient: .init(colors: [Color.white , Color.blue.opacity(circlePerimeter+1) , Color.white]), startPoint: .bottom, endPoint: .top))
                .fill(Color.white)
                //.rotationEffect(Angle(degrees: Double(-(1 - circlePerimeter) * 360 * 3)))
                .rotationEffect(Angle(degrees: Double( c2RotateSpeed * 360 )))
                .scaleEffect(c2StartSize)
                .shadow(color: Color.white, radius: shadowRadius)
                //.rotationEffect(Angle(degrees: rotateAngle))
                .animation(Animation.default, value: c2RotateSpeed)
                .onReceive(timer) { _ in
                    if (c2RotateSpeed > 0) {
                        c2RotateSpeed -= c2RotateRate
                    }
                    
                    
                    
                    if (c2StartSize > c2EndSize) {
                        c2StartSize -= c2SizeRate
                    }
                    
                    if (circlePerimeter >= 1) {
                        shadowRadius +=  shadowIncreaseRate
                        if (shadowRadius >= maxShadowRadius) {
                            shadowRadius = maxShadowRadius
                            shadowIncreaseRate = shadowIncreaseRate * -0.1
                            if (shadowFirstPhase){
                                shadowIncreaseRate = 0
                            }
                        }
                        
                        if (shadowRadius < 1) {
                            shadowFirstPhase = true
                            shadowIncreaseRate = shadowIncreaseRate * -4
                        }
                    } else {
                        circlePerimeter += c2TrimRate
                    }
                    /*
                    print("--------------------")
                    print(circlePerimeter)
                    print(shadowRadius)
                    */
                }
                 
        }
        .background(Color.black.ignoresSafeArea())
        
    }
}

struct CircleAnimation_Previews: PreviewProvider {
    static var previews: some View {
        CircleAnimation()
    }
}
