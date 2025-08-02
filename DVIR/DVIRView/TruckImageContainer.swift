//
//  TruckImageContainer.swift
//  TruckIn
//
//  Created by Abdulaziz Boyqoziyev  on 7/30/25.
//

import SwiftUI

struct TruckImageContainer: View {
    var title: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Truck Image va Matn
            HStack(alignment: .center, spacing: 8) {
                Image(systemName: "truck") // Truck icon
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.blue)

                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
            }

            // 3 ta gorizontal rasm
            HStack(spacing: 8) {
                ForEach(1...3, id: \.self) { index in
                    Image("truck.image\(index)") // "image1", "image2", "image3" bo‘lishi kerak
                        .resizable()
                        .scaledToFill()
//                        .frame(width: 95.67, height: 72)
                        .clipped()
                        .cornerRadius(10)
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}
