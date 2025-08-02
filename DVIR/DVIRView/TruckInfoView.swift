//
//  TruckInfoView.swift
//  TruckIn
//
//  Created by Abdulaziz Boyqoziyev  on 7/30/25.
//TextFielTestView

import SwiftUI

import SwiftUI

struct CustomTextFieldView: View {
    let placeholder: String
    let iconName: String
    @Binding var text: String

    
    
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            TextField(placeholder, text: $text, axis: .vertical)
                .padding(.trailing, 35)
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(lineWidth: 1.0)
                        .foregroundStyle(Color.clear)
                        .background(Color.gray.opacity(0.1)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                        )
                )

            Image(systemName: iconName)
                .foregroundColor(Color(uiColor: .systemBlue))
                .font(.title2)
                .padding(.trailing, 12)
                .padding(.bottom, 8)
        }
    }
}

struct TextFieldTestView: View {
    @State private var textFields: [String] = Array(repeating: "", count: 10)

    // Har bir icon uchun turli systemName ishlatamiz
    let icons = [
        "pencil", "paperplane", "person", "envelope", "phone",
        "lock", "calendar", "house", "book", "star"
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(0..<10, id: \.self) { index in
                    CustomTextFieldView(
                        placeholder: "Enter text \(index + 1)",
                        iconName: icons[index],
                        text: $textFields[index]
                    )
                }
            }
            .padding()
        }
    }
}
