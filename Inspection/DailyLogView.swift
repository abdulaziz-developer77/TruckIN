//
//  DailyLogView.swift
//  TruckIn
//
//  Created by Abdulaziz Boyqoziyev  on 8/24/25.
//

import SwiftUI

struct UTruckinScreen: View {
    @State private var isDarkMode = false
    @State private var signatureImage: UIImage?
    @State private var drawings: [[CGPoint]] = []
    @State private var currentDrawing: [CGPoint] = []
    
    // Device check
    var isIphone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
    var isiPadPortrait: Bool {
        UIDevice.current.userInterfaceIdiom == .pad &&
        UIScreen.main.bounds.height > UIScreen.main.bounds.width
    }
    var isiPadLandscape: Bool {
        UIDevice.current.userInterfaceIdiom == .pad &&
        UIScreen.main.bounds.width > UIScreen.main.bounds.height
    }
    
    var headerImageName: String {
        if isDarkMode {
            if isiPadLandscape { return "UTruckinIpadLandspaceDarkMode" }
            else if isiPadPortrait { return "UTruckinIpadDarkMode" }
            else { return "UTruckinIphoneDarkMode" }
        } else {
            if isiPadLandscape { return "UTruckinIpadLandspaceMode" }
            else if isiPadPortrait { return "UTruckinIpadPortraitLightMode" }
            else { return "UTruckinIphoneLightMode" }
        }
    }
    
    // Horizontal padding by device
    var horizontalPadding: CGFloat {
        if isiPadLandscape { return 240 }
        else if isiPadPortrait { return 32 }
        else { return 24 }
    }
    
    var buttonFrame: CGSize {
        if isIphone {
            return CGSize(width: 48, height: 44)
        } else {
            return CGSize(width: 56, height: 48)
        }
    }
    
    var buttonCornerRadius: CGFloat {
        isIphone ? 12 : 16
    }
    
    var buttonVerticalPadding: CGFloat { 8 }
    var buttonHorizontalPadding: CGFloat { 16 }
    
    var body: some View {
        ZStack {
            (isDarkMode ? Color(red: 28/255, green: 27/255, blue: 27/255) : Color.white)
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 24) {
                
                HStack {
                    Image(headerImageName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 28)
                    
                    Spacer()
                    
                    HStack(spacing: 10) {
                        Button(action: {
                            withAnimation { isDarkMode.toggle() }
                        }) {
                            Image("moonIphone")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .opacity(1)
                                .rotationEffect(.degrees(0))
                        }
                        .frame(width: buttonFrame.width,
                               height: buttonFrame.height)
                        .padding(.vertical, buttonVerticalPadding)
                        .padding(.horizontal, buttonHorizontalPadding)
                        .background(isDarkMode ?
                                    Color(red: 29/255, green: 62/255, blue: 69/255) :
                                    Color(red: 230/255, green: 244/255, blue: 247/255))
                        .cornerRadius(buttonCornerRadius)
                        
                        Button(action: {}) {
                            Image("translateIphone")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .opacity(1)
                                .rotationEffect(.degrees(0))
                        }
                        .frame(width: buttonFrame.width,
                               height: buttonFrame.height)
                        .padding(.vertical, buttonVerticalPadding)
                        .padding(.horizontal, buttonHorizontalPadding)
                        .background(isDarkMode ?
                                    Color(red: 29/255, green: 62/255, blue: 69/255) :
                                    Color(red: 230/255, green: 244/255, blue: 247/255))
                        .cornerRadius(buttonCornerRadius)
                    }
                }
                .padding(.horizontal, horizontalPadding)
                .padding(.top, 24)
                
                // TEXT CONTAINER
                VStack(alignment: .leading) {
                    Text("To proceed, we kindly ask you to provide your signature to confirm your identity and acknowledge that the information provided is accurate and belongs to you.")
                        .font(.system(size: 16, weight: .medium))
                        .lineSpacing(8)
                        .foregroundColor(isDarkMode ? .white : .black)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                }
                .background(isDarkMode ? Color(red: 28/255, green: 27/255, blue: 27/255) : Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(isDarkMode ?
                                Color(red: 53/255, green: 53/255, blue: 53/255) :
                                Color(red: 244/255, green: 244/255, blue: 244/255),
                                lineWidth: 1)
                )
                .cornerRadius(16)
                .padding(.horizontal, horizontalPadding)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(isDarkMode ? Color(red: 28/255, green: 27/255, blue: 27/255) : Color(red: 244/255, green: 244/255, blue: 244/255))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(isDarkMode ?
                                        Color(red: 53/255, green: 53/255, blue: 53/255) :
                                        Color(red: 244/255, green: 244/255, blue: 244/255),
                                        lineWidth: 1)
                        )
                    
                    if drawings.isEmpty {
                        Text("Sign here using your finger")
                            .foregroundColor(isDarkMode ? .white.opacity(0.7) : .black.opacity(0.7))
                            .font(.system(size: isiPadPortrait ? 32 : 16, weight: .semibold))
                    }
                    
                    SignatureCanvas(
                        drawings: $drawings,
                        currentDrawing: $currentDrawing,
                        signatureImage: $signatureImage,
                        isDarkMode: $isDarkMode
                    )
                    .cornerRadius(16)
                }
                .frame(width: isiPadPortrait ? 736 : nil,
                       height: isiPadPortrait ? 432 : 300)
                .padding(.horizontal, horizontalPadding)
                
                // BUTTONS
                if signatureImage != nil {
                    HStack(spacing: isiPadPortrait ? 32 : 10) {
                        // CLEAR
                        Button(action: {
                            drawings.removeAll()
                            signatureImage = nil
                        }) {
                            HStack(spacing: 8) {
                                Text("Clear")
                                    .foregroundColor(.white)
                                    .font(.system(size: 14, weight: .medium))
                                Image("delete.icon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 16, height: 16)
                            }
                        }
                        .frame(width: 106, height: isiPadPortrait ? 48 : 44)
                        .background(Color(red: 227/255, green: 72/255, blue: 72/255))
                        .cornerRadius(12)
                        .padding(.leading, horizontalPadding)
                        
                        // SAVE
                        Button(action: {
                            // save action
                        }) {
                            Text("Save")
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .medium))
                                .frame(maxWidth: .infinity)
                        }
                        .frame(height: isiPadPortrait ? 48 : 44)
                        .background(Color(red: 8/255, green: 145/255, blue: 178/255))
                        .cornerRadius(12)
                        .padding(.trailing, horizontalPadding)
                    }
                } else {
                    // SIGN IN
                    Button(action: {}) {
                        Text("Sign In")
                            .foregroundColor(.black)
                            .font(.system(size: 14, weight: .medium))
                            .frame(maxWidth: .infinity)
                    }
                    .frame(height: isiPadPortrait ? 48 : 44)
                    .background(Color(red: 165/255, green: 228/255, blue: 243/255))
                    .cornerRadius(12)
                    .padding(.horizontal, horizontalPadding)
                }
                
                Spacer()
            }
        }
    }
}

struct SignatureCanvas: View {
    @Binding var drawings: [[CGPoint]]
    @Binding var currentDrawing: [CGPoint]
    @Binding var signatureImage: UIImage?
    @Binding var isDarkMode: Bool
    
    var body: some View {
        GeometryReader { geo in
            Canvas { context, size in
                let strokeColor: Color = isDarkMode ? .white : .black
                
                for path in drawings {
                    var p = Path()
                    if let first = path.first {
                        p.move(to: first)
                        for point in path.dropFirst() {
                            p.addLine(to: point)
                        }
                        context.stroke(p, with: .color(strokeColor), lineWidth: 2)
                    }
                }
                
                var currentPath = Path()
                if let first = currentDrawing.first {
                    currentPath.move(to: first)
                    for point in currentDrawing.dropFirst() {
                        currentPath.addLine(to: point)
                    }
                    context.stroke(currentPath, with: .color(strokeColor), lineWidth: 2)
                }
            }
            .gesture(
                DragGesture(minimumDistance: 0.1)
                    .onChanged { value in
                        currentDrawing.append(value.location)
                    }
                    .onEnded { _ in
                        drawings.append(currentDrawing)
                        currentDrawing = []
                        signatureImage = renderSignature(size: geo.size)
                    }
            )
        }
    }
    
    private func renderSignature(size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { context in
            UIColor.clear.setFill()
            context.fill(CGRect(origin: .zero, size: size))
            
            let path = UIBezierPath()
            for line in drawings {
                guard let first = line.first else { continue }
                path.move(to: first)
                for point in line.dropFirst() {
                    path.addLine(to: point)
                }
            }
            
            let strokeColor: UIColor = isDarkMode ? .white : .black
            strokeColor.setStroke()
            path.lineWidth = 2
            path.stroke()
        }
    }
}

