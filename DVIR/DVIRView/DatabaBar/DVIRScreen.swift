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
            GeometryReader { proxy in
                let size = proxy.size

                ZStack(alignment: .top) {
                    VStack(spacing: 0) {
                        Color.primary100
                            .frame(height: size.height / 2)
                        Color.white
                            .frame(height: size.height / 2)
                    }
                    .ignoresSafeArea()
                    VStack(spacing: 0) {
                        VStack(spacing: 0) {
                            DVIRHeaderView(
                                onBack: { print("Back bosildi") },
                                onReload: { print("Reload bosildi") }
                            )
                            DateTabBarView(
                                selectedIndex: $viewModel.selectedIndex,
                                dates: viewModel.dates,
                                weekDays: viewModel.weekDays
                            )
                            Rectangle()
                                .fill(Color.primary100)
                                .frame(height: 20)
                        }
                        .background(Color.primary100)

                        VStack(spacing: 0) {
                            ScrollView {
                                LazyVStack(spacing: 16) {
                                    AllOfContainerWrapperView(size: size)
                                }
                                .padding(.top, 12)
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
                                    .background(Color.primary100)
                                    .cornerRadius(12)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 12)
                                    .padding(.bottom, 4)
                                    .background(Color.white)
                            }
                            .padding(.top, 8)
                            .background(Color.white)
                        }
                    }
                    .padding(.top, -8)
                    .ignoresSafeArea(.keyboard)
                }
            }
        }
    }
}
struct DVIRScreen_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                DVIRScreen()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .previewDevice("iPhone 16 Pro")
            .previewInterfaceOrientation(.portrait)
            .previewDisplayName("iPhone Portrait")
            
            NavigationView {
                DVIRScreen()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .previewDevice("iPad Pro 13-inch (M3)")
            .previewInterfaceOrientation(.portrait)
            .previewDisplayName("iPad Portrait")
            
            NavigationView {
                DVIRScreen()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .previewDevice("iPad Pro 13-inch (M3)")
            .previewInterfaceOrientation(.landscapeLeft)
            .previewDisplayName("iPad Landscape")
        }
    }
}
