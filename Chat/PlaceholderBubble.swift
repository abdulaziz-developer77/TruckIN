//
//  PlaceholderBubble.swift
//  TruckIn
//
//  Created by Abdulaziz Boyqoziyev  on 8/23/25.
//

import SwiftUI

struct PlaceholderBubble: View {
    var isMe: Bool
    var width: CGFloat
    var height: CGFloat
    var lines: Int
    
    var body: some View {
        HStack {
            if isMe { Spacer() }
            
            VStack(alignment: .leading, spacing: 6) {
                ForEach(0..<lines, id: \.self) { _ in
                    RoundedRectangle(cornerRadius: 12)
                        .fill(isMe ? Color.primary100 : Color.gray10)
                        .frame(width: width, height: height)
                }
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 50, height: 10)
            }
            
            if !isMe { Spacer() }
        }
    }
}
