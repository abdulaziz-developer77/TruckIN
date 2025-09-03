//
//  ChatBubble.swift
//  TruckIn
//
//  Created by Abdulaziz Boyqoziyev  on 8/23/25.
//

import SwiftUI

struct ChatBubble: View {
    let message: Message
    
    var body: some View {
        HStack {
            if message.isMe { Spacer() }
            
            VStack(alignment: message.isMe ? .trailing : .leading, spacing: 4) {
                Text(message.text)
                    .padding(12)
                    .background(message.isMe ? Color.primary100 : Color.gray10)
                    .foregroundColor(message.isMe ? Color.white :  Color.black)
                    .cornerRadius(16)
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.7,
                           alignment: message.isMe ? .trailing : .leading)
                    .id(message.id)
                
                Text(message.time)
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            
            if !message.isMe { Spacer() }
        }
    }
}
