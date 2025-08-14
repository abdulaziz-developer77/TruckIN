//
//  AllOfContainerView.swift
//  TruckIn
//
//  Created by Abdulaziz Boyqoziyev  on 8/5/25.
//

import SwiftUI

struct AllOfContainerView: View {
    let size: CGSize

    var body: some View {
        let deviceType = LayoutDeviceType.current(size)

        VStack(alignment: .leading, spacing: deviceType == .iPhone ? 16 : 24) {
            Text("Wednesday, June 11, 2025")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.black)

            VStack(spacing: deviceType == .iPhone ? 12 : 16) {
                if deviceType == .iPadLandscape {
                    HStack(alignment: .top, spacing: 16) {
                        TruckImageSection(size: size)
                            .frame(maxWidth: .infinity)
                        TrailerImageSection(size: size)
                            .frame(maxWidth: .infinity)
                    }
                } else {
                    VStack(spacing: 12) {
                        TruckImageSection(size: size)
                        TrailerImageSection(size: size)
                    }
                }

                InfoSection(size: size)

                if deviceType == .iPadLandscape {
                    HStack {
                        Spacer()
                        ActionButtonsSection(size: size)
                    }
                } else {
                    ActionButtonsSection(size: size)
                }
            }
            .padding(12)
            .background(Color.white)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.4), lineWidth: 1)
            )
        }
        .padding(12)
        .background(Color(red: 240/255, green: 242/255, blue: 244/255))
        .cornerRadius(12)
    }
}



struct AllOfContainerWrapperView: View {
    let size: CGSize

    var body: some View {
        VStack {
            AllOfContainerView(size: size)
        }
        .padding(12)
        .background(Color.white)
        .cornerRadius(16)
    }
}


