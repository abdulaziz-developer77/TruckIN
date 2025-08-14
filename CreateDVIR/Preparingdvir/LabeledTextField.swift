//
//  LabeledTextField.swift
//  TruckIn
//
//  Created by Abdulaziz Boyqoziyev  on 8/6/25.
//
import SwiftUI

struct LabeledTextField: View {
    let label: String
    @Binding var text: String
    var placeholder: String
    var icon: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.black)

            HStack {
                TextField("", text: $text, prompt: Text(placeholder).foregroundColor(Color(red: 139/255, green: 151/255, blue: 166/255)))
                    .padding(.leading, 12)
                    .frame(height: 44)

                if let icon = icon {
                    Button(action: {

                    }) {
                        Image(systemName: icon)
                            .foregroundColor(.gray)
                            .padding(.trailing, 12)
                    }
                }
            }
            .frame(height: 44)
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(red: 139/255, green: 151/255, blue: 166/255), lineWidth: 1)
            )
            .cornerRadius(8)
        }
        .padding(.horizontal, 16)
    }
}
