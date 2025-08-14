//
//  DVIRActionButtonsView.swift
//  TruckIn
//
//  Created by Abdulaziz Boyqoziyev  on 8/8/25.
//

import SwiftUI

struct DVIRActionButtonsView: View {
    var isFormValid: Bool
    var onReset: () -> Void
    var onSave: () -> Void
    
    var body: some View {
        HStack(spacing: 16) {
            Button(action: {}) {
                Image(systemName: "pencil")
                    .frame(width: 50, height: 50)
                    .background(Color.teal)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            
            Button(action: onReset) {
                Image(systemName: "trash")
                    .frame(width: 50, height: 50)
                    .background(isFormValid ? Color.red : Color.red.opacity(0.2))
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .disabled(!isFormValid)
            
            Spacer()
            
            Button(action: onSave) {
                Text("Save")
                    .frame(width: 100, height: 50)
                    .background(isFormValid ? Color.teal : Color.teal.opacity(0.3))
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .disabled(!isFormValid)
        }
        .padding(.top)
        .padding(.horizontal, 16)
    }
}
