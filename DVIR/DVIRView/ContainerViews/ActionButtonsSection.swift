//
//  ActionButtonsSection.swift
//  TruckIn
//
//  Created by Abdulaziz Boyqoziyev  on 8/1/25.
//

import SwiftUI

struct ActionButtonsSection: View {
    let size: CGSize
    
    var body: some View {
        let deviceType = LayoutDeviceType.current(size)
        let spacing: CGFloat = 8
        let width: CGFloat = deviceType == .iPhone ? 155.5 : 180
        let height: CGFloat = deviceType == .iPhone ? 44 : 48

        HStack(spacing: spacing) {
            ActionButton(title: "Edit", icon: "pencil", color: .blue, width: width, height: height)
            ActionButton(title: "Delete", icon: "trash", color: .red, width: width, height: height)
        }
        .frame(maxWidth: .infinity, alignment: {
            switch deviceType {
            case .iPhone: return .center
            case .iPadPortrait: return .leading
            case .iPadLandscape: return .trailing
            }
        }())
        .padding(.top, 12)
    }
}

