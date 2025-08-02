//
//  ActionButtonsSection.swift
//  TruckIn
//
//  Created by Abdulaziz Boyqoziyev  on 8/1/25.
//

import SwiftUI

struct ActionButtonsSection:  View {
    var body: some View {
        HStack(spacing: 8) {
            ActionButton(title: "Edite", icon: "edit_icon", color: Color(red: 8/255, green: 145/255, blue: 178/255, opacity: 1))
            ActionButton(title: "Delete", icon: "delete.icon", color: .red)
        }
        .padding(.top, 8)
    }
}
