//
//  ListWithIcon.swift
//  Routine
//
//  Created by Dajun Xian on 10/1/22.
//

import SwiftUI

struct ListWithIcon: View {
    @State private var showDetail = true
    @State private var animation = false
    let task: Task
    
    
    var body: some View {
        
        ZStack {
            Front(task: task).opacity(showDetail ? 0.0 : 1.0)
            Back(task: task).opacity(showDetail ? 1.0 : 0.0)
        }
        .modifier(FlipEffect(flipped: $showDetail, angle: animation ? 180 : 0, axis: (x: 1, y: 0)))
        .onTapGesture {
            withAnimation(Animation.linear(duration: 0.3)) {
                self.animation.toggle()
            }
        }
        
        
    }
}

struct Front: View {
    @Environment(\.colorScheme) var colorScheme
    let task: Task
    var body: some View {
        HStack {
            Image(task.type)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                .clipShape(Circle())
                .padding(3.0)
                .scaledToFit()
                //.foregroundColor(Color.blue)
            VStack {
                HStack {
                    Text(task.type)
                        .font(.title3)
                        .fontWeight(.regular)
                        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        .foregroundColor(colorScheme == .dark ? Color.white.opacity(0.7) : Color.black.opacity(0.7))
                    Spacer()
                    Text(task.time, style: .time)
                        .foregroundColor(colorScheme == .dark ? Color.white.opacity(0.5) : Color.black.opacity(0.3))
                    
                        
                }
            }
        }
        .frame(height: 60)
        .padding(.horizontal)
    }
}

struct Back: View {
    @Environment(\.colorScheme) var colorScheme
    let task: Task
    var body: some View {
        HStack {
            Image(task.type)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                .scaledToFit()
                
            VStack {
                HStack {
                    Image(systemName: "timer")
                    Text(task.getDuration())
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                        .font(.footnote)
                    Spacer()
                    Text(task.time, style: .time)
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                        .font(.footnote)
                }
                .opacity(0.6)
                HStack {
                    Text(task.title)
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                        .font(.footnote)
                        .opacity(0.8)
                        .lineLimit(2)
                    Spacer()
                }
                //.scaledToFit()
            }
            .padding(.leading, 4.0)
        }
        .frame(height: 60)
        .padding(.horizontal)
    }
}

struct FlipEffect: GeometryEffect {

      var animatableData: Double {
            get { angle }
            set { angle = newValue }
      }

      @Binding var flipped: Bool
      var angle: Double
      let axis: (x: CGFloat, y: CGFloat)

      func effectValue(size: CGSize) -> ProjectionTransform {

            DispatchQueue.main.async {
                  self.flipped = self.angle >= 90 && self.angle < 270
            }

            let tweakedAngle = flipped ? -180 + angle : angle
            let a = CGFloat(Angle(degrees: tweakedAngle).radians)

            var transform3d = CATransform3DIdentity;
            transform3d.m34 = -1/max(size.width, size.height)

            transform3d = CATransform3DRotate(transform3d, a, axis.x, axis.y, 0)
            transform3d = CATransform3DTranslate(transform3d, -size.width/2.0, -size.height/2.0, 0)

            let affineTransform = ProjectionTransform(CGAffineTransform(translationX: size.width/2.0, y: size.height / 2.0))

            return ProjectionTransform(transform3d).concatenating(affineTransform)
      }
}

struct ListWithIcon_Previews: PreviewProvider {
    static var previews: some View {
        let testTask = Task("Workout",title: "Go to the gym with nancy and gloria", startingHour: 8, startingMin: 0, hour: 3, min: 0, second: 10, time: Date())
        ListWithIcon(task: testTask )
    }
}

struct Back_Preview: PreviewProvider {
    static var previews: some View {
        let testTask = Task("Workout",title: "Go to the gym with nancy and gloria and remy and everyone", startingHour: 8, startingMin: 0, hour: 3, min: 0, second: 10, time: Date())
        Back(task: testTask )
    }
}
