//
//  DateValue.swift
//  Routine
//
//  Created by Chang on 10/7/22.
//

import SwiftUI

// Date Value Model...
struct DateValue: Identifiable{
    var id = UUID().uuidString
    var day: Int
    var date: Date
}
