//
//  ScrollableTagsInputField.swift
//  TruckIn
//
//  Created by Abdulaziz Boyqoziyev  on 8/6/25.
//

import SwiftUI

struct ScrollableTagsInputField: View {
    @Binding var text: String
    @Binding var tags: [String]
    
    var body: some View {
        ZStack(alignment: .trailing) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(tags, id: \.self) { tag in
                        Text(tag)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                    }
                    TextField("Add defect ...", text: $text)
                        .frame(minWidth: 80)
                    
                }
                .padding(.leading, 10)
                .padding(.trailing, 40)
            }
            
            Button(action: {
                let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
                guard !trimmed.isEmpty else { return }
                tags.append(trimmed)
                text = ""
            }) {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(.blue)
                    .font(.system(size: 22))
            }
            .padding(.trailing, 10)
        }
        .frame(height: 50)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
        )
    }
}

