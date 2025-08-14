//
//  TrailerImageSection.swift
//  TruckIn
//
//  Created by Abdulaziz Boyqoziyev  on 8/1/25.
//

import SwiftUI

struct TrailerImageSection: View {
    var size: CGSize
    
    var body: some View {
        let deviceType = LayoutDeviceType.current(size)
        let (imageHeight, spacing, cornerRadius) = imageLayout(for: deviceType)
        
        VStack(alignment: .leading, spacing: 8) {
            Text("Container Images")
                .font(.system(size: 14, weight: .semibold))
            
            HStack(spacing: spacing) {
                
                
                Image("Trailer.image1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
                    .frame(height: imageHeight)
                    .cornerRadius(cornerRadius)
                
                Image("Trailer.image2")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
                    .frame(height: imageHeight)
                    .cornerRadius(cornerRadius)
                
                Image("Trailer.image3")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
                    .frame(height: imageHeight)
                    .cornerRadius(cornerRadius)
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
        )
        .frame(maxWidth: .infinity, alignment: .center)
    }
    func imageLayout(for type: LayoutDeviceType) -> (CGFloat, CGFloat, CGFloat) {
        switch type {
        case .iPhone:
            return(72, 8, 10)
        case .iPadPortrait:
            return(128, 12, 10)
        case .iPadLandscape:
            return(118, 12, 10)
        }
    }
}
