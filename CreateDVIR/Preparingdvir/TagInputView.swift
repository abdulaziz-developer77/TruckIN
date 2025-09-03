//
//  TagInputView.swift
//  TruckIn
//
//  Created by Abdulaziz Boyqoziyev  on 8/6/25.
//

import SwiftUI

struct TagInputView: View {
    @Binding var tags: [String]
    @Binding var newTag: String

    var leadingPadding: CGFloat = 16
    var trailingPadding: CGFloat = 16

    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Add Defects")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.black)
            
            HStack(spacing: 8) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(tags, id: \.self) { tag in
                            HStack(spacing: 6) {
                                Text(tag)
                                    .font(.subheadline)
                                    .foregroundColor(.black)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 6)
                                    .background(Color.gray.opacity(0.2))
                                    .clipShape(RoundedRectangle(cornerRadius: 12))

                                Button(action: {
                                    withAnimation { tags.removeAll { $0 == tag } }
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.gray)
                                }
                            }
                        }

                        TextField("          ", text: $newTag)
                            .focused($isFocused)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .font(.subheadline)

                            .frame(minWidth: 80)
                    }
                    .padding(.vertical, 4)
                }

                Button(action: {
                    addTag()
                }) {
                    Image(systemName: "plus")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
            .padding(8)
            .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.4), lineWidth: 1))
        }
        .padding(.leading, leadingPadding)
        .padding(.trailing, trailingPadding)
    }

    private func addTag() {
        let trimmed = newTag.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        withAnimation {
            tags.append(trimmed)
            newTag = ""
            isFocused = true
        }
    }
}


