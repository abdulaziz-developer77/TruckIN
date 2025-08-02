//
//  TruckImageSection.swift
//  TruckIn
//
//  Created by Abdulaziz Boyqoziyev  on 8/1/25.
//
import SwiftUI

struct TruckImageSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 4) { //checked
            Text("Truck Image")
                .font(.system(size: 14, weight: .semibold))

            HStack(spacing: 8) { //checed
              
                 Image("truck.image")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                      
                        .clipped()
                        .cornerRadius(10)
                    
                    Image("truck.image")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                       
                        .clipped()
                        .cornerRadius(10)
                    
                    Image("truck.image")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        
                        .clipped()
                        .cornerRadius(10)
            }
        }
        .padding(8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
        )
    }
}
