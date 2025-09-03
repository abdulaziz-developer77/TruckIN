//
//  DateLabel.swift
//  TruckIn
//
//  Created by Abdulaziz Boyqoziyev  on 8/23/25.
//

import SwiftUI

struct DateLabel: View {
    let date: String
    
    var body: some View {
        Text(date.uppercased())
            .font(.system(size: 13, weight: .semibold, design: .default)) 
            .foregroundColor(Color.primary100)
            .multilineTextAlignment(.center)
            .frame(width: 81, height: 32, alignment: .center)
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.primary50, lineWidth: 1)
            )
            .cornerRadius(12)
    }
}
