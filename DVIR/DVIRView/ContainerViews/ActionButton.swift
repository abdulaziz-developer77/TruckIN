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
    var width: CGFloat
    var height: CGFloat
    
    
    
    var body: some View {
        Button(action: {
            
        }) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                Text(title)
                    .fontWeight(.semibold)
            }
            .frame(width: width, height: height)
            .background(color)
            .foregroundColor(.white)
            .cornerRadius(12)
        }
    }
}
