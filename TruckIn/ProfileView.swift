//
//  ProfileView.swift
//  TruckIn
//
//  Created by Abdulaziz Boyqoziyev on 7/27/25.
//

import SwiftUI


enum DeviceOrientation {
    case iPhone, iPadPortrait, iPadLandscape
}

struct DeviceOrientationKey: EnvironmentKey {
    static let defaultValue: DeviceOrientation = .iPhone
}

extension EnvironmentValues {
    var deviceOrientation: DeviceOrientation {
        get { self[DeviceOrientationKey.self] }
        set { self[DeviceOrientationKey.self] = newValue }
    }
}

// MAIN PROFILE VIEW
struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    @Environment(\.deviceOrientation) var deviceOrientation

    let constants = (
        space: CGFloat(8),
        padding: CGFloat(12)
    )

    var body: some View {
        NavigationView {
            Group {
                if deviceOrientation == .iPadLandscape {
                    GeometryReader { geometry in
                        ScrollView(.vertical, showsIndicators: true) {
                            HStack(spacing: constants.space) {
                                makeInfoView
                                    .frame(width: geometry.size.width * 0.375, height: geometry.size.height - 50)
                                
                                makeOptionsList
                                    .frame(width: geometry.size.width * 0.625, height: geometry.size.height - 50)
                            }
                            .frame(minHeight: geometry.size.height)
                            .padding(constants.padding)
                            .padding(.top, -120) // landscpace
                        }
                        .background(Color(.systemGroupedBackground))
                    }
                } else {
                    ScrollView(.vertical, showsIndicators: true) {
                        VStack(spacing: constants.space) {
                            makeInfoView
                            makeOptionsList
                        }
                        .padding(constants.padding)
                        .padding(.top, -75) //Portrait iPad
                    }
                    .background(Color(.systemGroupedBackground))
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack(spacing: 3) {
                        Button(action: {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.blue)
                        }
                        Text("Menu")
                            .font(.headline)
                            .foregroundColor(.primary)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .foregroundColor(.gray)
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    var makeInfoView: some View {
        VStack(spacing: 12) {
            infoBox(title: "Name", value: viewModel.user.name)
            infoBox(title: "ID", value: viewModel.user.id)
            infoBox(title: "Truck", value: viewModel.user.truck)
            infoBox(title: "Email", value: viewModel.user.email)
            infoBox(title: "Phone number", value: viewModel.user.phone)
            infoBox(title: "License NO", value: viewModel.user.licenseNumber)
            infoBox(title: "Issued state", value: viewModel.user.state)

            Button(action: {
                viewModel.logut()
            }) {
                HStack {
                    Text("Log out")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Image(systemName: "arrow.right.circle.fill")
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color.red)
                .cornerRadius(10)
            }

            Button(action: {}) {
                Text("Reverse support")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }

            Button(action: {}) {
                Text("App version 1.0.123")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
            }
            .disabled(true)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 3)
    }

    var makeOptionsList: some View {
        MenuView()
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 3)
    }

    func infoBox(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
            Text(value)
                .font(.body)
                .foregroundColor(.black)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
        .cornerRadius(10)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                ProfileView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .environment(\.deviceOrientation, .iPhone)
            .previewDevice("iPhone 16 Pro")
            .previewInterfaceOrientation(.portrait)
            .previewDisplayName("iPhone Portrait")

            NavigationView {
                ProfileView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .environment(\.deviceOrientation, .iPadPortrait)
            .previewDevice("iPad Pro 13-inch (M4)")
            .previewInterfaceOrientation(.portrait)
            .previewDisplayName("iPad Portrait")

            NavigationView {
                ProfileView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .environment(\.deviceOrientation, .iPadLandscape)
            .previewDevice("iPad Pro 13-inch (M4)")
            .previewInterfaceOrientation(.landscapeLeft)
            .previewDisplayName("iPad Landscape")
        }
    }
}
