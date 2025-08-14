//
//  DVIRSignatureView.swift
//  TruckIn
//
//  Created by Abdulaziz Boyqoziyev  on 8/8/25.
//

import SwiftUI

struct DVIRSignatureView: View {
    @Binding var showSignatureSheet: Bool
    @Binding var signatureImage: UIImage?
    var showValidationError: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Sign")
                .font(.headline)
                .padding(.horizontal, 16)
            
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(showValidationError && signatureImage == nil ? Color.red : Color.gray.opacity(0.3), lineWidth: 1)
                    .frame(height: 280)
                    .background(Color(.systemGray6))
                
                if let image = signatureImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .scaledToFit()
                        .frame(height: 280)
                        .cornerRadius(20)
                } else {
                    Text("Tap to sign")
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal, 16)
            .onTapGesture {
                withAnimation {
                    showSignatureSheet = true
                }
            }
        }
    }
}
