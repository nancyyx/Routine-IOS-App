//
//  UserCalendarViewModel.swift
//  Routine
//
//  Created by Chang You on 2022/10/25.
//

import SwiftUI

struct UserCalendarItemModel: Identifiable {
	let id: String = UUID().uuidString
	let day: String
	let style: Style
	let numberOfEvents: Int
	let isToday: Bool

	enum Style {
		case placeholder
		case day
	}
}

struct UserEventModel: Identifiable {
	let id: String = UUID().uuidString
	let title: String
	let content: String
}


class UserCalendarViewModel: ObservableObject {
	@Published var firstDayOfMonth: Int = 1
	@Published var numberOfTheMonth: Int = 28
	@Published var days: [UserCalendarItemModel] = []
	@Published var date: Date = Date()
	@Published var pickingDate: Date = Date()
	@Published var events: [UserEventModel] = []

	init() {
		updateDate()
	}

	func updateDate(_ date: Date = Date()) {
		self.date = date
		self.pickingDate = date

		let calendar = Calendar(identifier: .gregorian)
		let comps = calendar.dateComponents([.year, .month, .day], from: self.date)
		self.firstDayOfMonth = getCountOfDaysInMonth(year: comps.year!, month: comps.month!).week
		self.numberOfTheMonth = getCountOfDaysInMonth(year: comps.year!, month: comps.month!).count

		days = []
		for _ in 0..<(firstDayOfMonth-1) {
			days.append(UserCalendarItemModel(day: "", style: .placeholder, numberOfEvents: 0, isToday: false))
		}
		for number in (firstDayOfMonth - 1)...(firstDayOfMonth + numberOfTheMonth-2) {
			let isToday = number - firstDayOfMonth + 2 == comps.day!
			let model = UserCalendarItemModel(day: String(number - firstDayOfMonth + 2), style: .day, numberOfEvents: Int(arc4random()) % 10, isToday: isToday)
			if isToday {
				changeEvents(from: model)
			}
			days.append(model)
		}
		for _ in firstDayOfMonth+numberOfTheMonth-2...41 {
			days.append(UserCalendarItemModel(day: "", style: .placeholder, numberOfEvents: 0, isToday: false))
		}
	}

	func changeEvents(from item: UserCalendarItemModel) {
		if item.numberOfEvents <= 0 {
			events = []
			return
		}
		var models: [UserEventModel] = []
		for _ in 0...item.numberOfEvents {
			models.append(UserEventModel(title: randomString(length: Int(arc4random() % 8 + 1)), content: randomString(length: Int(arc4random() % 8 + 1))))
		}
		events = models
	}
}

func getCountOfDaysInMonth(year: Int, month: Int) -> (count: Int, week: Int) {
	let dateFormatter = DateFormatter()
	dateFormatter.dateFormat = "yyyy-MM"
	let date = dateFormatter.date(from: String(year)+"-"+String(month))
	let calendar: Calendar = Calendar(identifier: .gregorian)

	let range = calendar.range(of: .day, in: .month, for: date!)
	let week = calendar.component(.weekday, from: date!)
	return ((range?.count)!, week)
}

func randomString(length: Int) -> String {
	let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
	return String((0..<length).map{ _ in letters.randomElement()! })
}
