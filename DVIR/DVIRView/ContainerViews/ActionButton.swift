//
//  ActionButton.swift
//  TruckIn
//
//  Created by Abdulaziz Boyqoziyev  on 8/1/25.
//

import SwiftUI

struct ActionButton: View {
    var title: String
    var icon: String
    var color: Color
    
    var body: some View {
        Button(action: {
            
        }) {
            HStack(spacing: 8) {
                Text(title)
                        .fontWeight(.semibold)
                Image(icon)
                    .font(.system(size: 16))
            }
            .frame(width: 155.5, height: 44)
            .padding(.init(top: 8, leading: 8, bottom: 8, trailing: 8))
            .background(color.opacity(1))
            .foregroundColor(.white)
            .cornerRadius(12)
        }
    }
}
