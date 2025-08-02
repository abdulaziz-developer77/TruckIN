//
//  FloatingTextField.swift
//  TruckIn
//
//  Created by Abdulaziz Boyqoziyev  on 7/27/25.
//

import SwiftUI

struct FloatingTextField: View {
    var title: String
    @Binding var text: String
    var isSecure: Bool  = false
    
    @FocusState private var isFocused: Bool
    
    private var shouldFloatLabel: Bool {
        isFocused || !text.isEmpty
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            Text(title)
                .foregroundColor(shouldFloatLabel ? .accentColor : .gray)
                .font(.system(size: shouldFloatLabel ? 12 : 16))
                .offset(y: shouldFloatLabel ? -25 : 0)
                .scaleEffect(shouldFloatLabel ? 1.0 : 1.2, anchor: .leading)
                .animation(.easeInOut(duration: 0.2), value: shouldFloatLabel)
                .padding(.horizontal, 6)
            
            Group {
                if isSecure {
                    SecureField("", text: $text)
                        .focused($isFocused)
                } else {
                    TextField("", text: $text)
                        .focused($isFocused)
                }
            }
            .padding(.top, 8)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 10)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .stroke(isFocused ? Color.accentColor : Color.gray.opacity(0.5), lineWidth: 1.5)
                .background(Color.white)
        )
    }
    
}
