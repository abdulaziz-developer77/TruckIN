//
//  InfoSection.swift
//  TruckIn
//
//  Created by Abdulaziz Boyqoziyev  on 8/1/25.
//

import SwiftUI

struct InfoSection: View {
    let size: CGSize
    
    var body: some View {
        let deviceType = LayoutDeviceType.current(size)

        VStack(alignment: .leading, spacing: 12) {
            InfoRow(label: "Truck ID:", value: "10")
            InfoRow(label: "Date:", value: "Jul 09 TUESDAY")
            InfoRow(label: "Location:", value: "2.72 SW from Tashkent, Tk")
            InfoRow(label: "Odometer:", value: "100000.0")
            InfoRow(label: "Truck Defects:", value: "Lights (Stop), Parking brake, Body")
            InfoRow(label: "Trailer Defects:", value: "3475 Cir, Aurora, IL 605047")
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(deviceType == .iPhone ? 10 : 12)
        .overlay(
            RoundedRectangle(cornerRadius: deviceType == .iPhone ? 10 : 12)
                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
        )
    }
}
