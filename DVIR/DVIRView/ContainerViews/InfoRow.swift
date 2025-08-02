//
//  InfoRow.swift
//  TruckIn
//
//  Created by Abdulaziz Boyqoziyev  on 8/1/25.
//

import SwiftUI

struct InfoRow: View {
    
    var label: String
    var value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(label)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.gray)
                .padding(.bottom, 2)
            Text(value)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.black)
                .padding(.bottom, 12)
        }
    }
}
