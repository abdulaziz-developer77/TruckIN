//
//  ChatView.swift
//  TruckIn
//
//  Created by Abdulaziz Boyqoziyev  on 8/23/25.
//

import SwiftUI

struct Message: Identifiable {
    let id: UUID
    let text: String
    let isMe: Bool
    let time: String
    let date: String
}


struct ChatView: View {
    @State private var isLoading = true
    @State private var messages: [Message] = [
        Message(id: UUID(), text: "Many desktop publishing packages and", isMe: false, time: "11:22 AM", date: "August 20"),
        Message(id: UUID(), text: "English. Many desktop publishing packages and web page editors...", isMe: false, time: "10:20 PM", date: "August 20"),
        Message(id: UUID(), text: "There are many variations of passages", isMe: true, time: "11:27 AM", date: "August 20"),
        Message(id: UUID(), text: "All the Lorem Ipsum generators", isMe: true, time: "11:27 AM", date: "August 20"),
        Message(id: UUID(), text: "My truck broke down", isMe: false, time: "11:30 AM", date: "August 20")
    ]
    
    @State private var newMessage = ""
    
    var body: some View {
        GeometryReader { geo in
            let pad = edgePadding(size: geo.size)
            
            VStack(spacing: 0) {
                if isLoading {
                    ScrollView {
                        VStack(spacing: 30) {
                            DateLabel(date: "August 20")
                            
                            VStack(spacing: 20) {
                                PlaceholderBubble(isMe: false, width: 200, height: 50, lines: 1)
                                PlaceholderBubble(isMe: false, width: 280, height: 60, lines: 3)
                                PlaceholderBubble(isMe: true,  width: 180, height: 40, lines: 1)
                                PlaceholderBubble(isMe: true,  width: 200, height: 40, lines: 1)
                                PlaceholderBubble(isMe: false, width: 240, height: 40, lines: 1)
                            }
                            .padding(.horizontal, pad)
                        }
                        .padding(.vertical, 16)
                    }
                    .background(Color.white.ignoresSafeArea())
                } else {
                    ScrollViewReader { proxy in
                        ScrollView {
                            VStack(spacing: 30) {
                                ForEach(groupedByDate(), id: \.key) { date, msgs in
                                    VStack(spacing: 16) {
                                        DateLabel(date: date)
                                        
                                        VStack(spacing: 12) {
                                            ForEach(msgs) { message in
                                                ChatBubble(message: message)
                                            }
                                        }
                                        .padding(.horizontal, pad)
                                    }
                                }
                            }
                            .padding(.vertical, 16)
                        }
                        .onChange(of: messages.count) { _ in
                            withAnimation {
                                proxy.scrollTo(messages.last?.id, anchor: .bottom)
                            }
                        }
                    }
                    .background(Color.white.ignoresSafeArea())
                }
                
                // Input container
                HStack {
                    HStack (spacing: 0) {
                        TextField("Type a message...", text: $newMessage, axis: .vertical)
                            .lineLimit(1...4)
                            .padding(.horizontal, 10)
                        SendButton(action: sendMessage)

                    }
                    .padding(8)
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(radius: 1)
                }
                .padding(.horizontal, pad)
                .padding(.vertical, 6)
                .background(Color.white)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation { isLoading = false }
                }
            }
        }
    }
    
    private func edgePadding(size: CGSize) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return size.width > size.height ? 52 : 16
        } else {
            return 12
        }
    }
    
    private func sendMessage() {
        guard !newMessage.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        let time = formatter.string(from: Date())
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd"
        let date = dateFormatter.string(from: Date())
        
        let message = Message(id: UUID(), text: newMessage, isMe: true, time: time, date: date)
        messages.append(message)
        newMessage = ""
    }
    
    private func groupedByDate() -> [(key: String, value: [Message])] {
        let grouped = Dictionary(grouping: messages) { $0.date }
        return grouped.sorted { lhs, rhs in
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM dd"
            if let d1 = formatter.date(from: lhs.key),
               let d2 = formatter.date(from: rhs.key) {
                return d1 < d2
            }
            return lhs.key < rhs.key
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                ChatView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .previewDevice("iPhone 16 Pro")
            .previewInterfaceOrientation(.portrait)
            .previewDisplayName("iPhone Portrait")
            
            NavigationView {
                ChatView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .previewDevice("iPad Pro 13-inch (M3)")
            .previewInterfaceOrientation(.portrait)
            .previewDisplayName("iPad Portrait")
            
            NavigationView {
                ChatView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .previewDevice("iPad Pro 13-inch (M3)")
            .previewInterfaceOrientation(.landscapeLeft)
            .previewDisplayName("iPad Landscape")
        }
    }
}
