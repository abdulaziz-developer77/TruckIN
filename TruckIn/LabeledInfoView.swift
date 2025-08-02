//
//  LabeledInfoView.swift
//  TruckIn
//
//  Created by Abdulaziz Boyqoziyev  on 7/27/25.
//

import SwiftUI

struct LabeledInfoView: View {
    var title: String
    var value: String
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(value)
                        .font(.body)
                        .foregroundColor(.primary)
                }
                Spacer()
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            
            Divider()
                .background(Color.gray.opacity(0.3))
                .padding(.leading, 16)
        }
        .background(Color.white)
    }
}
