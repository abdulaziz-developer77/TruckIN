//
//  FullContainerView.swift
//  TruckIn
//
//  Created by Abdulaziz Boyqoziyev  on 7/30/25.
//

import SwiftUI

struct FullContainerView: View {
    var body: some View {
        GeometryReader {  proxy in
            let size = proxy.size
            
            VStack(alignment: .leading, spacing: 12) {
                Text("Wednesday, June 11, 2025")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
                
                VStack(spacing: 0) {
                    TruckImageSection(size: size)
                    Spacer().frame(height: 12)
                    TrailerImageSection(size: size)
                    Spacer().frame(height: 8)
                    InfoSection(size: size)
                    ActionButtonsSection(size: size)
                }
                .padding(8)
                .background(Color.white)
                .cornerRadius(12)
            }
            .padding(8)
            .background(Color(red: 240/255, green: 242/255, blue: 244/255))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.4), lineWidth: 1)
            )
        }
    }
}
