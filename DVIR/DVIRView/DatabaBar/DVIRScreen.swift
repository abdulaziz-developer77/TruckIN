//
//  DVIRScreen.swift
//  TruckIn
//
//  Created by Abdulaziz Boyqoziyev  on 7/30/25.
//


import SwiftUI

struct DVIRScreen: View {
    @StateObject private var viewModel = DVIRViewModel()
    @State private var isPresentingCreateDvir = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    DVIRHeaderView(
                        onBack: { print("Back bosildi") },
                        onReload: { print("Reload bosildi") }
                    )
                    
                    DateTabBarView(selectedIndex: $viewModel.selectedIndex, dates: viewModel.dates, weekDays: viewModel.weekDays)
                    
                    Rectangle()
                        .fill(Color(red: 41/255, green: 148/255, blue: 177/255))
                        .frame(height: 12)
                }
                .background(Color(red: 41/255, green: 148/255, blue: 177/255))
                
                GeometryReader { geometry in
                    VStack(spacing: 0) {
                        ScrollView {
                            LazyVStack(spacing: 16) {
                                FullContainerView()
                            }
                            .padding(.top, 12)
                            .padding(.horizontal, 12)
                        }
                        
                        NavigationLink(destination: CreateDVIR(), isActive: $isPresentingCreateDvir) {
                            EmptyView()
                        }

                        Button(action: {
                            isPresentingCreateDvir = true
                        }) {
                            Text("Add DVIR +")
                                .frame(maxWidth: .infinity)
                                .frame(height: 44)
                                .background(Color(red: 8/255, green: 145/255, blue: 178/255))
                                .cornerRadius(12)
                                .foregroundColor(.white)
                                .padding(.horizontal, 12)
                                .padding(.bottom, 4)
                        }
                        .padding(.top, 4)
                    }
                }
            }
            .background(Color(.systemGroupedBackground))
            .ignoresSafeArea(.keyboard)
        }
    }
}

#Preview {
    DVIRScreen()
}
