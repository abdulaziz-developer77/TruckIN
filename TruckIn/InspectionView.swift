//
//  InspectionView.swift
//  TruckIn
//
//  Created by Abdulaziz Boyqoziyev  on 7/28/25.
//




import SwiftUI

enum DeviceType {
    case iPhone, iPadPortrait, iPadLandscape

    static func current(_ size: CGSize) -> DeviceType {
        if size.width > size.height && UIDevice.current.userInterfaceIdiom == .pad {
            return .iPadLandscape
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            return .iPadPortrait
        } else {
            return .iPhone
        }
    }
}

struct InspectionView: View {
    @State private var size: CGSize = .zero

    var body: some View {
        GeometryReader { geometry in
            let device = DeviceType.current(geometry.size)

            VStack(spacing: 0) {
                CustomNavigationBar()

                ScrollView {
                    VStack(spacing: 20) {
                        if device != .iPadLandscape {
                            Image("exampleImage")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 12)
                                .cornerRadius(12)
                                .padding(.horizontal)
                        }

                        if device == .iPadLandscape {
                            HStack(spacing: 20) {
                                cardView(
                                    title: "Review logs previous 7 days + today",
                                    subtitle: "Tap 'Begin inspection' and hand your device to the officer",
                                    buttonText: "Begin inspection"
                                )

                                cardView(
                                    title: "Send ELD Output File to DOT",
                                    subtitle: "Tap 'Send ELD Output File to DOT'",
                                    buttonText: "Send File"
                                )
                            }
                            .frame(height: 860)
                            .padding(.horizontal)
                            .padding(.top, 10)
                        } else {
                            VStack(spacing: 20) {
                                cardView(
                                    title: "Review logs previous 7 days + today",
                                    subtitle: "Tap 'Begin inspection' and hand your device to the officer",
                                    buttonText: "Begin inspection"
                                )

                                cardView(
                                    title: "Send ELD Output File to DOT",
                                    subtitle: "Tap 'Send ELD Output File to DOT'",
                                    buttonText: "Send File"
                                )
                            }
                            .frame(height: 1400)
                            .padding(.horizontal)
                            .padding(.top, -20)
                        }
                    }
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                }
                .onAppear {
                    self.size = geometry.size
                }
                .onChange(of: geometry.size) { newSize in
                    self.size = newSize
                }
            }
        }
        .background(Color.white)
    }

    func cardView(title: String, subtitle: String, buttonText: String) -> some View {
        VStack(spacing: 16) {
            Text(title)
                .font(.title2.bold())
                .multilineTextAlignment(.center)

            Text(subtitle)
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)

            Button(action: {
               
            }) {
                Text(buttonText)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue.opacity(0.55))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.blue.opacity(0.15))
        .cornerRadius(15)
    }
}


struct CustomNavigationBar: View {
    var body: some View {
        HStack {
            HStack(spacing: 8) {
                Button(action: {
                    // Back action
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.blue)
                }

                Text("Inspection")
                    .font(.headline)
                    .foregroundColor(.blue)
            }

            Spacer()

            HStack(spacing: 16) {
                Button(action: {
                    // Toggle dark mode
                }) {
                    Image(systemName: "moon.fill")
                        .foregroundColor(.blue)
                }

                Button(action: {
                    // Refresh action
                }) {
                    Image(systemName: "arrow.clockwise")
                        .foregroundColor(.blue)
                }
            }
        }
        .padding(.horizontal)
        .frame(height: 70)
        .background(Color.blue.opacity(0.2)) // ✅ Custom background
    }
}



struct InspectionView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                InspectionView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .environment(\.deviceOrientation, .iPhone)
            .previewDevice("iPhone 16 Pro")
            .previewInterfaceOrientation(.portrait)
            .previewDisplayName("iPhone Portrait")

            NavigationView {
                InspectionView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .environment(\.deviceOrientation, .iPadPortrait)
            .previewDevice("iPad Pro 13-inch (M4)")
            .previewInterfaceOrientation(.portrait)
            .previewDisplayName("iPad Portrait")

            NavigationView {
                InspectionView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .environment(\.deviceOrientation, .iPadLandscape)
            .previewDevice("iPad Pro 13-inch (M4)")
            .previewInterfaceOrientation(.landscapeLeft)
            .previewDisplayName("iPad Landscape")
        }
    }
}

