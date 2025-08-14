//
//  CreateDVIR.swift
//  TruckIn
//
//  Created by Abdulaziz Boyqoziyev  on 8/1/25.
//

import SwiftUI

struct CreateDVIR: View {
    @State private var showSignatureSheet = false
    @State private var signatureImage: UIImage? = nil

    var body: some View {
        NavigationStack {
            ZStack {
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
                                    CreateDVIRTextField(
                                        showSignatureSheet: $showSignatureSheet,
                                        signatureImage: $signatureImage
                                    )
                                }
                                .padding(.top, 12)
                                .padding(.horizontal, 12)
                            }
                        }
                    }
                }
                .background(Color(.systemGroupedBackground))
                .ignoresSafeArea(.keyboard)

                if showSignatureSheet {
                    SignatureView(
                        showSignatureSheet: $showSignatureSheet,
                        signatureImage: $signatureImage
                    )
                    .transition(.scale)
                    .zIndex(1)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct CreateDVIR_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                CreateDVIR()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .environment(\.deviceOrientation, .iPhone)
            .previewDevice("iPhone 16 Pro")
            .previewInterfaceOrientation(.portrait)
            .previewDisplayName("iPhone Portrait")
            
            NavigationView {
                DVIRScreen()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .environment(\.deviceOrientation, .iPadPortrait)
            .previewDevice("iPad Pro 13-inch (M3)")
            .previewInterfaceOrientation(.portrait)
            .previewDisplayName("iPad Portrait")
            
            NavigationView {
                DVIRScreen()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .environment(\.deviceOrientation, .iPadLandscape)
            .previewDevice("iPad Pro 13-inch (M3)")
            .previewInterfaceOrientation(.landscapeLeft)
            .previewDisplayName("iPad Landscape")
        }
    }
}

