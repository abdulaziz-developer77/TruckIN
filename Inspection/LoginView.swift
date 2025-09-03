//
//  LoginView.swift
//  TruckIn
//
//  Created by Abdulaziz Boyqoziyev  on 9/4/25.
//

import SwiftUI

extension Color {
    static let segmentUnselectedLight = Color(red: 230/255, green: 244/255, blue: 247/255)
    static let signDisabledLight = Color(red: 165/255, green: 228/255, blue: 243/255)
    static let signEnabledLight = Color(red: 8/255, green: 145/255, blue: 178/255)
    
    // Dark mode
    static let darkBackground = Color(red: 28/255, green: 27/255, blue: 27/255)
    static let segmentUnselectedDark = Color(red: 29/255, green: 62/255, blue: 69/255)
    static let buttonBackgroundDark = Color(red: 29/255, green: 62/255, blue: 69/255)
    static let labelDark = Color(red: 210/255, green: 209/255, blue: 209/255)
    static let textfieldBorderDark = Color(red: 73/255, green: 73/255, blue: 73/255)
    static let textfieldBackgroundDark = Color(red: 53/255, green: 53/255, blue: 53/255)
    static let placeholderDark = Color(red: 103/255, green: 107/255, blue: 111/255)
    static let signDisabledDark = Color(red: 18/255, green: 86/255, blue: 103/255)
    static let footerTextDark = Color(red: 125/255, green: 138/255, blue: 155/255)
}

struct SegmentItem {
    let imageName: String
    let title: String
}

struct SegmentedControlView: View {
    @Binding var selectedIndex: Int
    let items: [SegmentItem]
    let isDarkMode: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(items.indices, id: \.self) { i in
                Button(action: { selectedIndex = i }) {
                    HStack(spacing: 8) {
                        Image(items[i].imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                            .foregroundColor(selectedIndex == i ? .white : .primary)
                        
                        Text(items[i].title)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(selectedIndex == i ? .white : .primary)
                    }
                    .frame(maxWidth: .infinity, minHeight: 40, maxHeight: 44)
                    .background(
                        ZStack {
                            (isDarkMode ? Color.segmentUnselectedDark : Color.segmentUnselectedLight)
                            if selectedIndex == i {
                                RoundedRectangle(cornerRadius: 11)
                                    .fill(Color.signEnabledLight)
                                    .padding(4)
                            }
                        }
                    )
                }
                .buttonStyle(.plain)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct ErrorBanner: View {
    let isIpad: Bool
    let isLandscape: Bool
    let message: String
    
    var body: some View {
        HStack(spacing: 12) {
            if isIpad {
                if isLandscape {
                    Image("IncorrectIconIpadLandspace")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 20)
                } else {
                    Image("IncorrectIconIpadPortrait")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 20)
                }
            } else {
                Image("IncorrectIconIphone")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 20)
            }
            
            Text(message)
                .foregroundColor(.black)
                .font(.system(size: 15, weight: .medium))
                .lineLimit(1)
                .truncationMode(.tail)
        }
        .frame(maxWidth: .infinity)
        .frame(height: isIpad ? 48 : 44)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 4)
        .padding(.top, isIpad ? (isLandscape ? 32 : 8) : 8)
        .padding(.horizontal, isIpad ? (isLandscape ? 406.5 : 220.5) : 24)
        .transition(.move(edge: .top).combined(with: .opacity))
        .animation(.spring(), value: message)
    }
}

struct IpadActionButtons: View {
    let isDarkMode: Bool
    let onToggleDarkMode: () -> Void
    let onTranslate: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            Button(action: onToggleDarkMode) {
                Image("moonIphone")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 18)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
            }
            .frame(width: 56, height: 48)
            .background(isDarkMode ? Color.buttonBackgroundDark : Color.segmentUnselectedLight)
            .cornerRadius(16)
            
            Button(action: onTranslate) {
                Image("translateIphone")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 18)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
            }
            .frame(width: 56, height: 48)
            .background(isDarkMode ? Color.buttonBackgroundDark : Color.segmentUnselectedLight)
            .cornerRadius(16)
        }
    }
}

struct LoadingDots: View {
    @Binding var activeIndex: Int
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<3, id: \.self) { i in
                Circle()
                    .strokeBorder(Color.white.opacity(0.5), lineWidth: 0.5)
                    .background(
                        Circle()
                            .fill(i == activeIndex ? Color.white : Color(red: 8/255, green: 145/255, blue: 178/255))
                    )
                    .frame(width: 7, height: 7)
            }
        }
    }
}

struct LoginView: View {
    @State private var selectedSegment = 0
    @State private var username = ""
    @State private var password = ""
    @State private var isDarkMode = false
    @State private var showPassword = false
    
    @State private var showError = false
    @State private var isLoading = false
    @State private var activeDot = 0
    let dotTimer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geo in
            let isIpad = UIDevice.current.userInterfaceIdiom == .pad
            let isLandscape = geo.size.width > geo.size.height
            let horizontalPadding: CGFloat = isIpad ? (isLandscape ? 240 : 32) : 24
            let textFieldHeight: CGFloat = 48
            
            ZStack(alignment: .top) {
                (isDarkMode ? Color.darkBackground : .white)
                    .ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 28) {
                    
                    if showError {
                        ErrorBanner(
                            isIpad: isIpad,
                            isLandscape: isLandscape,
                            message: "Incorrect password. Please try again."
                        )
                    }
                    
                    Spacer().frame(height: showError ? 40 : 0)
                    
                    if isIpad {
                        HStack {
                            Image(isDarkMode ? "UTruckinIphoneDarkMode" : "UTruckinIphoneLightMode")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 40)
                                .padding(.leading, isLandscape ? 240 : 32)
                            
                            Spacer()
                            
                            HStack(spacing: 12) {
                                SegmentedControlView(
                                    selectedIndex: $selectedSegment,
                                    items: [
                                        SegmentItem(imageName: "LogInIphone", title: "Log in"),
                                        SegmentItem(imageName: "FaceIdIphone", title: "Face id")
                                    ],
                                    isDarkMode: isDarkMode
                                )
                                .frame(width: 200, height: 48)
                                
                                IpadActionButtons(
                                    isDarkMode: isDarkMode,
                                    onToggleDarkMode: { isDarkMode.toggle() },
                                    onTranslate: {}
                                )
                            }
                            .padding(.trailing, isLandscape ? 240 : 32)
                        }
                    } else {
                        VStack(alignment: .leading, spacing: 24) {
                            Image(isDarkMode ? "UTruckinIphoneDarkMode" : "UTruckinIphoneLightMode")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 40)
                                .padding(.top, 24)
                                .padding(.leading, 24)

                            HStack {
                                SegmentedControlView(
                                    selectedIndex: $selectedSegment,
                                    items: [
                                        SegmentItem(imageName: "LogInIphone", title: "Log in"),
                                        SegmentItem(imageName: "FaceIdIphone", title: "Face id")
                                    ],
                                    isDarkMode: isDarkMode
                                )
                                .frame(width: 200, height: 48)

                                Spacer()

                                HStack(spacing: 8) {
                                    Button(action: { isDarkMode.toggle() }) {
                                        Image("moonIphone")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 18)
                                            .padding(.vertical, 8)
                                            .padding(.horizontal, 16)
                                    }
                                    .frame(width: 48, height: 44)
                                    .background(isDarkMode ? Color.buttonBackgroundDark : Color.segmentUnselectedLight)
                                    .cornerRadius(12)

                                    Button(action: {}) {
                                        Image("translateIphone")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 18)
                                            .padding(.vertical, 8)
                                            .padding(.horizontal, 16)
                                    }
                                    .frame(width: 48, height: 44)
                                    .background(isDarkMode ? Color.buttonBackgroundDark : Color.segmentUnselectedLight)
                                    .cornerRadius(12)
                                    .padding(.trailing, 24)
                                }
                            }
                            .padding(.leading, 24)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 24) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Username")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(isDarkMode ? Color.labelDark : .primary)
                            
                            HStack(spacing: 12) {
                                Image("usernameIphone")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                
                                TextField("", text: $username, prompt: Text("Enter username").foregroundColor(isDarkMode ? Color.placeholderDark : .gray))
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                    .foregroundColor(isDarkMode ? .white : .primary)
                                
                                if !username.isEmpty {
                                    Button(action: { username = "" }) {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                            .frame(height: textFieldHeight)
                            .padding(.horizontal, 12)
                            .background(isDarkMode ? Color.textfieldBackgroundDark : Color(UIColor.systemGray6))
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(isDarkMode ? Color.textfieldBorderDark : .clear, lineWidth: 1))
                            .cornerRadius(12)
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Password")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(isDarkMode ? Color.labelDark : .primary)
                            
                            HStack(spacing: 12) {
                                Image("passwordIphone")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                
                                Group {
                                    if showPassword {
                                        TextField("", text: $password, prompt: Text("Type something").foregroundColor(isDarkMode ? Color.placeholderDark : .gray))
                                    } else {
                                        SecureField("", text: $password, prompt: Text("Type something").foregroundColor(isDarkMode ? Color.placeholderDark : .gray))
                                    }
                                }
                                .foregroundColor(isDarkMode ? .white : .primary)
                                
                                Button(action: { showPassword.toggle() }) {
                                    Image("eyeIphone")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 22, height: 22)
                                }
                            }
                            .frame(height: textFieldHeight)
                            .padding(.horizontal, 12)
                            .background(isDarkMode ? Color.textfieldBackgroundDark : Color(UIColor.systemGray6))
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(isDarkMode ? Color.textfieldBorderDark : .clear, lineWidth: 1))
                            .cornerRadius(12)
                        }
                    }
                    .padding(.horizontal, horizontalPadding)
                    
                    Button(action: {
                        if password != "12345" {
                            withAnimation {
                                showError = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                withAnimation {
                                    showError = false
                                }
                            }
                        } else {
                            isLoading = true
                            activeDot = 0
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 9) {
                                isLoading = false
                            }
                        }
                    }) {
                        ZStack {
                            if isLoading {
                                LoadingDots(activeIndex: $activeDot)
                                    .onReceive(dotTimer) { _ in
                                        withAnimation {
                                            activeDot = (activeDot + 1) % 3
                                        }
                                    }
                            } else {
                                Text("Sign in")
                                    .fontWeight(.semibold)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .foregroundColor(.white)
                        .background(
                            (username.isEmpty || password.isEmpty)
                            ? (isDarkMode ? Color.signDisabledDark : Color.signDisabledLight)
                            : Color.signEnabledLight
                        )
                        .cornerRadius(12)
                    }
                    .disabled(username.isEmpty || password.isEmpty)
                    .padding(.horizontal, horizontalPadding)
                    
                    Text("Don't you have account? Please contact your carrier")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(isDarkMode ? Color.footerTextDark : Color.footerTextDark)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, horizontalPadding)
                        .padding(.top, 16)
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
