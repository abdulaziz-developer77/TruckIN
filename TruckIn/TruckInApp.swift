//
//  TruckInApp.swift
//  TruckIn
//
//  Created by Abdulaziz Boyqoziyev  on 7/26/25.
//

import SwiftUI

@main
struct TruckInApp: App {
    var body: some Scene {
        WindowGroup {
            ()
        }
    }
}



/*
 
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
                             .frame(height: 890)
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

 
 */




/*
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
                                     .frame(width: geometry.size.width * 0.375)
                                 makeOptionsList
                                     .frame(width: geometry.size.width * 0.625)
                             }
                             .frame(minHeight: geometry.size.height)
                             .padding(constants.padding)
                             .padding(.top, -75) // 👈 Bu yerda yuqoridagi bo‘shliq kamaytirilgan
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
                         .padding(.top, -75)
                     }
                     .background(Color(.systemGroupedBackground))
                 }
             }
             .navigationBarTitleDisplayMode(.inline)
             .toolbar {
                 // Chap tarafda: Back button + Menu text
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
                 // O'ng tarafda: Image
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

 */
