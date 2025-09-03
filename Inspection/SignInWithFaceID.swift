//
//  SignInWithFaceID.swift
//  TruckIn
//
//  Created by Abdulaziz Boyqoziyev  on 8/31/25.
//

import SwiftUI
import LocalAuthentication

struct FaceIDRegistrationView: View {
    @State private var isRegistering = false
    @State private var authMessage: String?
    @State private var isAuthenticated = false
    
    var body: some View {
        VStack(spacing: 40) {
            
            Text("For faster and more secure logins, you can register your Face ID. This allows you to access your account with just a glance—no password needed. Your face data stays private and secure on your device.")
                .font(.system(size: 16))
                .multilineTextAlignment(.center)
                .lineSpacing(6)
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
                .padding(.horizontal, 24)
            
            Spacer()
            
            Button(action: {
                authenticateWithFaceID()
            }) {
                ZStack {
                    Circle()
                        .fill(Color.blue.opacity(0.1))
                        .frame(width: 220, height: 220)
                        .overlay(
                            Circle()
                                .stroke(Color.blue.opacity(0.3), lineWidth: 4)
                        )
                    
                    Image(systemName: "faceid")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundColor(Color(red: 0/255, green: 145/255, blue: 178/255))
                        .scaleEffect(isRegistering ? 1.1 : 1.0)
                        .animation(.spring(), value: isRegistering)
                }
            }
            
            Text("Face ID registration")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(Color(red: 0/255, green: 145/255, blue: 178/255))
            
            if let message = authMessage {
                Text(message)
                    .foregroundColor(isAuthenticated ? .green : .red)
                    .font(.system(size: 14, weight: .medium))
                    .padding(.top, 8)
            }
            
            Spacer()
        }
        .background(Color.white.ignoresSafeArea())
    }
    
    private func authenticateWithFaceID() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authenticate with Face ID to continue"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authError in
                DispatchQueue.main.async {
                    if success {
                        self.isAuthenticated = true
                        self.authMessage = "✅ Face ID setup successful!"
                    } else {
                        self.isAuthenticated = false
                        self.authMessage = "❌ Authentication failed. Try again."
                    }
                }
            }
        } else {
            // No Face ID
            DispatchQueue.main.async {
                self.isAuthenticated = false
                self.authMessage = "Face ID not available on this device."
            }
        }
    }
}


