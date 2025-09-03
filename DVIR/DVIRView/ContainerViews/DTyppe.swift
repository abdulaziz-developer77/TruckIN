//
//  DTyppe.swift
//  TruckIn
//
//  Created by Abdulaziz Boyqoziyev  on 8/5/25.
//

import SwiftUI

enum LayoutDeviceType {
    case iPhone
    case iPadPortrait
    case iPadLandscape

    static func current(_ size: CGSize) -> LayoutDeviceType {
        let isPad = UIDevice.current.userInterfaceIdiom == .pad
        let isLandscape = size.width > size.height

        if isPad {
            return isLandscape ? .iPadLandscape : .iPadPortrait
        } else {
            return .iPhone
        }
    }
}

