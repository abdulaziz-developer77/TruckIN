//
//  DVIR.swift
//  TruckIn
//
//  Created by Abdulaziz Boyqoziyev  on 7/30/25.
//

import Foundation

struct DVIR: Identifiable {
    let id: UUID
    let truckID: Int
    let date: String
    let location: String
    let odometer: Double
    let truckImages: [String] // image names or URLs
    let trailerImages: [String]
    let truckDefects: String
    let trailerDefects: String
}
