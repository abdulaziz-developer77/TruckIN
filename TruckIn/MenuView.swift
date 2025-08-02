//
//  MenuView.swift
//  TruckIn
//
//  Created by Abdulaziz Boyqoziyev  on 7/27/25.
//

import SwiftUI

struct MenuItem: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
    let iconColor: Color
}

struct MenuView: View {
    
    let menuItems: [MenuItem] = [
        .init(icon: "shield", title: "Inspection", iconColor: .blue),
        .init(icon: "person.2", title: "Switch to co-driver", iconColor: .blue),
        .init(icon: "plus.square", title: "Add Status", iconColor: .blue),
        .init(icon: "pencil.and.outline", title: "Certification", iconColor: .blue),
        .init(icon: "info.circle", title: "Information", iconColor: .blue),
        .init(icon: "exclamationmark.triangle", title: "Malfunction", iconColor: .blue),
        .init(icon: "bubble.left.and.bubble.right", title: "Feedback", iconColor: .blue),
        .init(icon: "gearshape", title: "Settings", iconColor: .blue),
        .init(icon: "person.crop.circle", title: "Go to Play Store", iconColor: .blue)
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                ForEach(menuItems) { item in
                    HStack {
                        Image(systemName: item.icon)
                            .foregroundColor(item.iconColor)
                            .font(.system(size: 20))
                            .frame(width: 30)
                        
                        Text(item.title)
                            .foregroundColor(.black)
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 2)
                }
            }
            .padding()
        }
        .background(Color.white.ignoresSafeArea())
    }
}
