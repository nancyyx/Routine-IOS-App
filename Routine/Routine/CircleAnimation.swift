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
    @State var t = 0.0
    @State var k = 0.0 // k -> custom cos function
    @State var k2 = 0.0
    @State var iconTimer = 0.0
    @State var c1Timer = 0.0
    @State var c2Timer = 0.0
    @State var iconOpacity = 1.0
    @State var c1Opacity = 0.0
    @State var c2Opacity = 0.0
    @State var shadowFirstPhase = false
    @State var circlePerimeter = 0.0
    @State var shadowRadius = 1.0
    @State var shadowIncreaseRate = 1.8
    let maxShadowRadius = 23.0
    @State var lineWidthIndex = 0.0
    let c1TrimRate = 0.006
    let c2TrimRate = 0.006
    @State var c1RotateSpeed = 0.0
    @State var c2RotateSpeed = 0.0
    let c1RotateStartSpeed = 10.0
    let c2RotateStartSpeed = 10.0
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
        /*
         Geometry structure:
         
         Z:
            Inner Ring
                overlay black Circle with white shadow
                        overlay Icon
         
            Outer Ring
         */
        
        ZStack {
            Circle()
                .trim(from: 0.0, to: circlePerimeter)
                .stroke(style: StrokeStyle(lineWidth: 15 * lineWidthIndex, lineCap: .round, lineJoin: .round))
                //.fill(LinearGradient(gradient: .init(colors: [Color.white , Color.blue.opacity(circlePerimeter+1)]), startPoint: .bottom, endPoint: .top))
                .fill(Color.white.opacity(c1Opacity))  //inner circle color
                .rotationEffect(Angle(degrees: Double( c1RotateSpeed * -60 )))
                .scaleEffect(c1StartSize)
                .shadow(color:
                            c2Opacity == 0.0 ? Color.white.opacity(0.8) : Color.white.opacity(0.3),
                        radius:
                            c2Opacity == 0.0 ? shadowRadius/1.5 : shadowRadius/1.2)  //inner circle
                //.rotationEffect(Angle(degrees: rotateAngle))
                .overlay(
                    Circle()
                        .frame(width: 150, height: 150)
                        .foregroundColor(shadowFirstPhase ? Color.black : Color.clear)
                        .shadow(
                            color:
                                c2Opacity == 0.0 ?
                                    c1Opacity == 0.0 ? Color.white.opacity(iconOpacity - 0.7) : Color.white.opacity(iconOpacity - 0.4) :
                                Color.white.opacity(iconOpacity - 0.3)
                            , radius:
                                c2Opacity == 0.0 ?
                            c1Opacity == 0.0 ? shadowRadius/2.5  : shadowRadius/2  :
                                shadowRadius/1.2
                        )
                              
                        .overlay(
                            Image("routineIcon")
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: 130, height: 130)
                                //.clipShape(Circle())
                                .scaledToFit()
                            
                                .foregroundColor(shadowFirstPhase ? Color.white.opacity(iconOpacity) : Color.clear)
                                .shadow(color: Color.white, radius: shadowRadius/16)
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
                //.animation(Animation.default, value: c1RotateSpeed)
                .onReceive(timer) { _ in

                    if (lineWidthIndex < 1) {
                        t += 0.009
                        k = (1-cos(pow(t,1.4)))/1.99   // (1-cos(pow(t,1.4))) in [0,2], f(t) [0,20/19]   x = 1.2pi/2 -> f = max
                        k2 = (1-cos(pow(t,3)/3.4))/1.99
                        // (1-cos(pow(t,3)/3.4)) in [0,2], /1.99 then f(t) could slightly > 1 to exist if statement
                        // k2 ends at the same point as k, but increase slower than k
                        lineWidthIndex = k2
                        c1Opacity = k
                        c2Opacity = k
                        circlePerimeter = k
                        c1RotateSpeed = 1 + 25*(1.0021432326405575-k) - 0.14276399353842506
                        c2RotateSpeed = 1 + 30*(1.0021432326405575-k) - 0.17131679224611007
                        c1StartSize = c1StartConst + k * (c1EndSize - c1StartConst)
                        c2StartSize = c2StartConst - k * (c2StartConst - c2EndSize)

                        /*
                        if (k < 1) {
                            c1RotateSpeed = c1RotateStartSpeed * (1 - k)
                            c2RotateSpeed = c2RotateStartSpeed * (1 - k)
                        }
                        else {
                            c1RotateSpeed = 1.0
                            c2RotateSpeed = 1.0
                        }
                         */
                        /*
                        print(" ------ ")
                        print(c1RotateSpeed)
                        print(c2RotateSpeed)
                         */
                    }
                    else {
                        shadowRadius += shadowIncreaseRate
                        
                        if (shadowRadius >= maxShadowRadius) {
                            shadowRadius = maxShadowRadius
                            shadowIncreaseRate = shadowIncreaseRate * -0.15
                            if (shadowFirstPhase){
                                shadowIncreaseRate = 0
                                c1Timer += 0.1
                                c2Timer += 0.1
                                iconTimer += 0.1
                                if (iconTimer >= 14) {
                                    iconOpacity = 0.0
                                }
                                if (c1Timer >= 10) {
                                    c1Opacity = 0.0
                                    
                                }
                                if (c2Timer >= 5.5) {
                                    c2Opacity = 0.0
                                }
                            }
                        }
                        
                        if (shadowRadius < 0) {
                            shadowFirstPhase = true
                            shadowIncreaseRate = shadowIncreaseRate * -2.5
                        }
                    }
                    /*
                    if (c1RotateSpeed > 0) {
                        c1RotateSpeed -= c1RotateRate
                    }
                     */
                    /*
                    if (c2StartSize > c2EndSize) {
                        c2StartSize = (1-cos(t/2)) * (c2StartConst - c2EndSize)
                        //circlePerimeter += c1TrimRate
                        
                    }
                    
                    if (c1StartSize < c1EndSize) {
                        c1StartSize = (1-cos(t/2)) * (c1EndSize - c1StartConst)
                        //circlePerimeter += c1TrimRate
                        
                    }
                     *//*else {
                        circlePerimeter += c1TrimRate
                    }
                    */
                    /*
                    print("--------------------")
                    print(circlePerimeter)
                    print(shadowRadius)
                    print(c1RotateSpeed)
                    */
                }
                
            Circle()
                .trim(from: 0.0, to: circlePerimeter)
                .stroke(style: StrokeStyle(lineWidth: 20 * lineWidthIndex, lineCap: .round, lineJoin: .round))
                //.fill(LinearGradient(gradient: .init(colors: [Color.white , Color.blue.opacity(circlePerimeter+1) , Color.white]), startPoint: .bottom, endPoint: .top))
                .fill(Color.white.opacity(c2Opacity))
                //.rotationEffect(Angle(degrees: Double(-(1 - circlePerimeter) * 360 * 3)))
                .rotationEffect(Angle(degrees: Double( c2RotateSpeed * 91 )))
                .scaleEffect(c2StartSize)
                .shadow(color: Color.white.opacity(0.7), radius: shadowRadius)
                //.rotationEffect(Angle(degrees: rotateAngle))
                //.animation(Animation.default, value: c2RotateSpeed)
                .onReceive(timer) { _ in
                    /*
                    if (c2RotateSpeed > 0) {
                        c2RotateSpeed -= c2RotateRate
                    }
                     */
                    
                    
                    /*
                    if (c2StartSize > c2EndSize) {
                        c2StartSize -= c2SizeRate
                        //circlePerimeter += c2TrimRate
                        //c2Opacity += c2TrimRate
                    } else {
                        shadowRadius +=  shadowIncreaseRate
                        if (shadowRadius >= maxShadowRadius) {
                            shadowRadius = maxShadowRadius
                            shadowIncreaseRate = shadowIncreaseRate * -0.1  //decrease
                            
                        }
                    }
                     */
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
