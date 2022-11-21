//
//  CircleSPin.swift
//  Routine
//
//  Created by Dajun Xian on 11/18/22.
//

import SwiftUI

struct CircleSPin: View {
    @State var t = 0.3
    @State var t2 = 0.5
    @State var t3 = 0.0
    @State var k1 = 0.0
    @State var k2 = 0.0
    @State var k3 = 0.0
    
    @State var a = 0.0
    @State var b = 0.0
    @State var shift = 5.0
    @State var shiftDirection = 1.0
    @State var pos = 0.0
    
    var body: some View {
        let timer = Timer.publish(every: 0.01, on: .main, in:
                .common).autoconnect()
     
        
        ZStack {
            /*
            ForEach (1..<5) { i in
                
                HStack {
                    
                    Circle()
                        .frame(width: 6.5, height: 6.5)
                        .foregroundColor(Color.white.opacity(0.5))
                        .padding(.leading, 4.0)
                    //.background(Color.red)
                    Spacer()
                }
                .rotationEffect(Angle(degrees:(
                    Double(i) * (70 - k2)    // initial position
                    + shift
                )))
            }
            
            */
            ForEach (3..<10) { i in
                
                HStack {
                    
                    Circle()
                        .frame(width: 5.0, height: 5.0)
                        .foregroundColor(Color.white.opacity(0.9))
                        .padding(.leading, 7.0)
                    //.background(Color.red)
                    Spacer()
                }
                .rotationEffect(Angle(degrees:(
                    Double(i) * (52 - k2)    // initial position
                    + shift
                    //+ t3
   
                   
                )))
                .onReceive(timer) { _ in
                    t += 0.007
                    t2 += 0.07
                    //t3 += 0.05
                    a =  Double(Int.random(in: 1..<5))
                    b =  Double(Int.random(in: 5..<10))
                    
                    k1 = sin(t)
                    k2 = 1.1 * k1
                    
                    shift += 0.01 * shiftDirection
                    
                    if (shift > b) {
                        shiftDirection = b
                        shiftDirection = -shiftDirection
                    }
                    
                    
                    if (shift < a) {
                        shiftDirection = a
                        shiftDirection = -shiftDirection
                    }
                    
                    
                    
                }
            }
            /*
            ForEach (1..<13) { i in
                
                HStack {
                    Circle()
                    
                        .frame(width: 5.0, height: 5.0)
                        .foregroundColor(Color.white.opacity(0.8))
                        .padding(.leading, 23.0)

                    
                    Spacer()
                }
                .rotationEffect(Angle(degrees:(
                    10 * k2     // sin vibration
                    + shift     // random shift
                    + Double(i * 30 )    // initial position
                    + t * k2         // spinning
                )))
                
            }
            
            ForEach (1..<13) { i in
                
                HStack {
                    
                    Circle()
                        .frame(width: 5.0, height: 5.0)
                        .foregroundColor(Color.white.opacity(0.8))
                        .padding(.leading, 38.0)
                    //.background(Color.red)
                    Spacer()
                }
                .rotationEffect(Angle(degrees:(
                    10 * k2     // sin vibration
                    + shift     // random shift
                    + Double(i * 30)    // initial position
                    + t         // spinning
                )))
            }
            */
            /*
             ForEach (1..<4) { i in
             
             ForEach (0..<18) { j in
             
             HStack {
             
             Circle()
             
             .frame(width: 5.0, height: 5.0)
             .foregroundColor(Color.white.opacity(
             Double((i/2)) * k2
             ))
             .padding(.leading, 30.0 + CGFloat(10 * i))
             Spacer()
             }
             .rotationEffect(Angle(degrees: (i * k2) * 15 * k2 + (Double(j * 20) - (i * k2) * t2)))
             
             }
             
             }
             */
            
        }
        .rotationEffect(Angle(degrees:(
            t2   // initial position
            //+ t3

           
        )))
        .padding()

    }
    
    
}

struct CircleSPin_Previews: PreviewProvider {
    static var previews: some View {
        CircleSPin()
            .preferredColorScheme(.dark)
    }
}
