//
//  ProfileViewModel.swift
//  TruckIn
//
//  Created by Abdulaziz Boyqoziyev  on 7/27/25.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var user = UserProfile(
        name: "SHUKURKHON AKHDRKNONOV",
        id: "120",
        truck: "#89123798211",
        email: "mr.shukurxon@gmail.com",
        phone: "(205) 555-0100",
        licenseNumber: "P642685841778",
        state: "Florida"
    )
    
    func logut() {
        
    }
}
