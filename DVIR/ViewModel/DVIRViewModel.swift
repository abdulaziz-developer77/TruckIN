//
//  DVIRViewModel.swift
//  TruckIn
//
//  Created by Abdulaziz Boyqoziyev  on 7/30/25.
//

import Foundation

class DVIRViewModel: ObservableObject {
    @Published var dates: [String] = ["JAN 8", "JAN 9", "JAN 10", "JAN 11", "JAN 12", "JAN 13"]
    @Published var weekDays: [String] = ["Mon", "Tue", "Thu", "Wed", "Thu", "Fri", "Sat", "Sun"]
    @Published var selectedIndex: Int = 3 // masalan, "JAN 10"
}

