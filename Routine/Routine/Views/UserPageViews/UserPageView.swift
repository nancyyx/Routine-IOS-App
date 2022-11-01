//
//  UserPageView.swift
//  Routine
//
//  Created by Dajun Xian on 10/2/22.
//

import SwiftUI

struct UserPageView: View {
	// Start & End date should be configured based on your needs.
	@State private var isShowDatePicker: Bool = false

	@StateObject private var calenderVM: UserCalendarViewModel = UserCalendarViewModel()

    var body: some View {
        //NavigationView{
            VStack{
				ScrollView {
					VStack(spacing: 7) {
						//My Profile
						HStack {
							Text("PROFILE")
								.font(.title)
								.fontWeight(.semibold)
								.padding()

							Spacer()
						}

						//NavigationLink(destination: ProfilePicView()){
						Image("me")
							.resizable()
							.aspectRatio(contentMode: .fit)
							.frame(width: 125)
							.clipShape(Circle())
							.overlay(Circle().stroke(Color.white, lineWidth: 5))

						//}
						Text("Name")
							.font(.system(size: 30))
							.foregroundColor(.black)
						Text("Happy life:)")
							.font(.system(size:18))
							.foregroundColor(.black)
						Text("Edit")
							.font(.system(size: 14))
							.foregroundColor(.gray)

						VStack(spacing: 0){
							Section {
								Text("Points")
									.padding()
									.frame(maxWidth: .infinity, alignment: .leading)
								Divider()

								Text("Calender")
									.padding()
									.frame(maxWidth: .infinity, alignment: .leading)
								Divider()

								Text("Achivements")
									.padding()
									.frame(maxWidth: .infinity, alignment: .leading)
								Divider()
							}

							VStack {
								HStack {
									Button {
										withAnimation {
											calenderVM.pickingDate = calenderVM.date
											isShowDatePicker = true
										}
									} label: {
										Text(calenderVM.date, style: .date)
									}
								}
								.padding()

								dateBody
								if !calenderVM.events.isEmpty {
									dateEventsList
								}
							}
						}
						.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
						.background {
							Color.white
						}
					}
				}

                //.padding(.top, 40)


            }
			.background {
				Color(red:225 / 255, green: 225 / 255, blue: 225 / 255)
					.edgesIgnoringSafeArea(.all)
			}
			.overlay {
				if isShowDatePicker {
					datePickerView
				}
			}

        //}.navigationBarTitle("My Profile")
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
			.background {
				Color.gray.opacity(0.3)
			}

			LazyVGrid(columns: Array(repeating: GridItem(spacing: 0), count: 7)) {
				ForEach(calenderVM.days, id: \.id){ item in
					if item.style == .placeholder {
						Text(item.day)
						.frame(maxWidth: .infinity, maxHeight: .infinity)
					}
					else {
						ZStack {
							HStack {
								Button(item.day) {
									calenderVM.changeEvents(from: item)
								}
								.accentColor(.black)
							}
							.padding(10)
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
//			.frame(height: 300)
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
			.background {
				Color.white
			}
			VStack {
				DatePicker(selection: $calenderVM.pickingDate, displayedComponents: .date) {
					Text(calenderVM.date, style: .date)
				}
				.datePickerStyle(.wheel)
				.labelsHidden()
				.ignoresSafeArea()
			}
			.frame(maxWidth: .infinity, alignment: .bottom)
			.background {
				Color.white
					.ignoresSafeArea()
			}
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
		.background {
			Color.black.opacity(0.3).ignoresSafeArea()
		}

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
        UserPageView()
    }
}
