//
//  CreateDVIR.swift
//  TruckIn
//
//  Created by Abdulaziz Boyqoziyev  on 8/1/25.
//

import SwiftUI

struct CreateDVIR: View {
    @State private var isPresentingCreateDvir = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    DVIRHeaderView(
                        onBack: { print("Back bosildi") },
                        onReload: { print("Reload bosildi") }
                        
                    )
                                        
                    Rectangle()
                        .fill(Color(red: 41/255, green: 148/255, blue: 177/255))
                        .frame(height: 12)
                }
                .background(Color(red: 41/255, green: 148/255, blue: 177/255))
                
                GeometryReader { geometry in
                    VStack(spacing: 0) {
                        ScrollView {
                            LazyVStack(spacing: 16) {
                                CreateDVIRTextField()
                            }
                            .padding(.top, 12)
                            .padding(.horizontal, 12)
                        }
                        
                    }
                }
            }
            .background(Color(.systemGroupedBackground))
            .ignoresSafeArea(.keyboard)
        }
        .navigationBarBackButtonHidden(true) // 👈 bu yerda yashiramiz

    }
    
}

