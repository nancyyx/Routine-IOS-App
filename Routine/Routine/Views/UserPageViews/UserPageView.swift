//
//  UserPageView.swift
//  Routine
//
//  Created by Dajun Xian on 10/2/22.
//

import SwiftUI

struct ProfilePicView: View {
    var body: some View {
        Image("me")
            .resizable()
            .frame(width: 200, height: 200)
    }
}

struct UserPageView: View {
    @Environment(\.colorScheme) var colorScheme
    // Start & End date should be configured based on your needs.
    @State private var isShowDatePicker: Bool = false
    @EnvironmentObject var userViewModel: UserViewModel
    @State var presentEdit = false
    @StateObject private var calenderVM: UserCalendarViewModel = UserCalendarViewModel()
    
    var body: some View {
        //NavigationView{
        VStack{
            ScrollView {
                VStack() {
                    HStack {
                        Text("PROFILE")
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding()
                            .shadow(color: colorScheme == .dark ? Color.white : Color.clear, radius: 1.0)
                        
                        Spacer()
                    }
                    
                    Button {
                        print("Update user info")
                        presentEdit = true
                    } label: {
                        VStack {
                            Image("me")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 5))
                            
                            HStack {
                                Text(userViewModel.userName)
                                    .font(.system(size: 25))
                                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                                    .padding(.trailing)
                                
                                
                                Image(systemName: "suit.diamond.fill")
                                    .foregroundColor(Color(.systemYellow))
                                    .shadow(color: Color(.systemYellow), radius: 4)
                                    
                                    //.opacity(0.9)
                                Text("35")
                                    .foregroundColor(Color(.systemYellow))
                                    //.shadow(color: Color(.systemYellow), radius: 4)
                                
                            }
                            
                            Text(userViewModel.sup)
                                .font(.system(size:15))
                                .foregroundColor(.black)
                                .opacity(0.7)
                        }
                    }
                    .sheet(isPresented: $presentEdit) {
                        EditPageView(name: userViewModel.userName, text: userViewModel.sup, userPageView: self)
                    }
                    
                    //Divider()
                    
                   
                    
                    VStack {
                        Button {
                            withAnimation {
                                calenderVM.pickingDate = calenderVM.date
                                isShowDatePicker = true
                            }
                        } label: {
                            //Spacer()
                            Spacer()
                            Text(calenderVM.date, style: .date)
                                .font(.title3)
                                .fontWeight(.medium)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(Color.gray)
                        }
                        .foregroundColor(.blue)
                        .padding()
                        .frame(height: 40)
                        .cornerRadius(15, corners: [.topLeft, .topRight])
                        
                        Divider().foregroundColor(Color.gray.opacity(0.1))
                        
                        dateBody
                            .padding()
                        
                        Divider()
                        if !calenderVM.events.isEmpty {
                            dateEventsList
                        }
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .background(colorScheme == .dark ? Color.gray.opacity(0.2) : Color.white)
                    .cornerRadius(15)
                    //.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(.gray.opacity(0.1))
                            .shadow(radius: 10)
                    )
                    .padding()
                }
            }
            
            //.padding(.top, 40)
            
        }
        .overlay {
            if isShowDatePicker {
                datePickerView
            }
        }
        
    }
    
    var dateBody: some View {
        VStack {
            LazyVGrid(columns: Array(repeating: GridItem(spacing: 2), count: 7)) {
                Text("S")
                Text("M")
                Text("T")
                Text("W")
                Text("T")
                Text("F")
                Text("S")
            }
            .foregroundColor(colorScheme == .dark ? Color.white : Color.black.opacity(0.8))
            
            LazyVGrid(columns: Array(repeating: GridItem(spacing: 0), count: 7)) {
                ForEach(calenderVM.days, id: \.id){ item in
                    if item.style == .placeholder {
                        Text(item.day)
                            .font(.footnote)
                            .fontWeight(.thin)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .foregroundColor(colorScheme == .dark ? Color.white : Color.black.opacity(0.8))
                    }
                    else {
                        ZStack {
                            HStack {
                                Button(item.day) {
                                    calenderVM.changeEvents(from: item)
                                }
                                .accentColor(colorScheme == .dark ? Color.white : Color.black.opacity(0.7))
                            }
                            .padding(5)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background {
                                Circle()
                                    .fill(Color.blue)
                                    .opacity((Double(item.numberOfEvents) / 10.0))
                            }
                            
                            if item.isToday {
                                Circle().fill(Color.red)
                                    .frame(width: 8, height: 8)
                                    .offset(y: 15)
                            }
                        }
                    }
                }
            }
            //            .frame(height: 300)
        }
    }
    
    var datePickerView: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Button("Cancel") {
                    calenderVM.pickingDate = calenderVM.date
                    isShowDatePicker = false
                }
                .padding()
                
                Spacer()
                
                Button("Done") {
                    calenderVM.date = calenderVM.pickingDate
                    calenderVM.updateDate(calenderVM.date)
                    isShowDatePicker = false
                }
                .padding()
            }
            .frame(maxWidth: .infinity)
            .background(colorScheme == .dark ? Color.black : Color.white)
            VStack {
                DatePicker(selection: $calenderVM.pickingDate, displayedComponents: .date) {
                    Text(calenderVM.date, style: .date)
                }
                .datePickerStyle(.wheel)
                .labelsHidden()
                .ignoresSafeArea()
            }
            .frame(maxWidth: .infinity, alignment: .bottom)
            .background(colorScheme == .dark ? Color.black : Color.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .background(colorScheme == .dark ? Color.black : Color.gray.opacity(0.1))
        
    }
    
    var dateEventsList: some View {
        VStack {
            ForEach(calenderVM.events, id: \.id) { item in
                VStack(alignment: .leading) {
                    Text(item.title)
                    Text(item.content)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                .padding()
                .frame(height: 44)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .frame(maxWidth: .infinity, alignment: .top)
    }
}

struct UserPageView_Previews: PreviewProvider {
    static var previews: some View {
        UserPageView().environmentObject(UserViewModel())
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}


extension Date {

    var onlyDate: Date? {
        get {
            let calender = Calendar.current
            let dateComponents = calender.dateComponents([.year, .month, .day], from: self)
            return calender.date(from: dateComponents)
        }
    }

}


extension Date: Strideable {
    public func distance(to other: Date) -> TimeInterval {
        return other.timeIntervalSinceReferenceDate - self.timeIntervalSinceReferenceDate
    }

    public func advanced(by n: TimeInterval) -> Date {
        return self + n
    }
}

