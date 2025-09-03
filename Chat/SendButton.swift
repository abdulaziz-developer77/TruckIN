//
//  SendButton.swift
//  TruckIn
//
//  Created by Abdulaziz Boyqoziyev  on 8/23/25.
//

import SwiftUI

struct SendButton: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var action: () -> Void 
    
    var body: some View {
        Button(action: action) {
            Image(getIconName())
                .resizable()
                .scaledToFit()
                .frame(width: iconSize().width, height: iconSize().height)
        }
    }
    
    func getIconName() -> String {
        if UIDevice.current.userInterfaceIdiom == .pad {
            if verticalSizeClass == .regular {
                return "sendIpadPortrait"
            } else {
                return "sendIpadLandscape"
            }
        } else {
            return "sendIphone"
        }
    }
    
    func iconSize() -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return CGSize(width: 56, height: 56)
        } else {
            return CGSize(width: 48, height: 48)
        }
    }
}
