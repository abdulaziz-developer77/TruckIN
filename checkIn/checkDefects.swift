

import SwiftUI

struct TruckDefectsView: View {
    var device: DeviceType
    
    @State private var defects: [String: Bool] = [
        "Lights (stop)": false, "Parking Brake": false, "Body": false, "Air Lines": false,
        "None": false, "Battery": false, "Air leaks": false, "ABS light": false,
        "Air hoses": false, "Slack adjuster": false, "Steering wheel": false, "Clutch": false,
        "Drive line": false, "Fifth Wheel": false, "Fuel Tanks": false, "Front Axle": false,
        "Horn": false, "Lights (Turn indicators)": false, "Mirrors": false, "Mufflers": false,
        "Oil Pressure": false, "Radiator": false, "Safety Equipments": false, "Starter": false,
        "Transmission": false, "Tires": false
    ]
    
    @State private var showTrailerView = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 0) {
                Text("Truck defects")
                    .font(.system(size: 22, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, leadingPadding)
                    .padding(.top, titleTopPadding)
                
                Divider()
                    .frame(height: 1)
                    .background(Color.gray.opacity(0.4))
                    .padding(.horizontal, horizontalPadding)
                    .padding(.top, 16)
                
                ScrollView {
                    LazyVGrid(columns: gridColumns, spacing: gridSpacing) {
                        ForEach(defects.keys.sorted(), id: \.self) { key in
                            HStack(spacing: 8) {
                                Button {
                                    defects[key]?.toggle()
                                } label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 4)
                                            .fill(defects[key] == true ? Color.primary100 : Color.white)
                                            .frame(width: 16, height: 16)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 4)
                                                    .stroke(defects[key] == true ? Color.primary100 : Color.black, lineWidth: 1)
                                            )
                                        
                                        if defects[key] == true {
                                            Image(systemName: "checkmark")
                                                .font(.system(size: 10, weight: .bold))
                                                .foregroundColor(.white)
                                        }
                                    }
                                }
                                .buttonStyle(PlainButtonStyle())
                                
                                Text(key)
                                    .font(.subheadline)
                                    .frame(height: 22)
                                    .foregroundColor(defects[key] == true ? Color.primary100 : Color.black)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.8)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding(.horizontal, horizontalPadding)
                    .padding(.top, 16)
                    .padding(.bottom, 16)
                }
                
                Divider()
                    .frame(height: 1)
                    .background(Color.black.opacity(0.1))
                    .padding(.horizontal, horizontalPadding)
                    .padding(.bottom, 16)
                
                HStack(spacing: buttonSpacing) {
                    Button(action: {}) {
                        HStack(spacing: 8) {
                            Text("Other")
                                .foregroundColor(Color.primary100)
                            
                            Image(systemName: "chevron.right")
                                .foregroundColor(Color.primary100)
                        }
                        .frame(width: buttonWidth, height: buttonHeight)
                        .background(Color.primary10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.primary100, lineWidth: 1.5)
                        )
                        .cornerRadius(12)
                    }
                    
                    Button {
                        showTrailerView = true
                    } label: {
                        Text("Save")
                            .fontWeight(.semibold)
                            .frame(width: buttonWidth, height: buttonHeight)
                            .background(Color.primary100)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                }
                .padding(.horizontal, horizontalPadding)
                .padding(.bottom, buttonBottomPadding)
            }
            
            Button(action: { presentationMode.wrappedValue.dismiss() }) {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .frame(width: 40, height: 40)
                    .background(Color.black.opacity(0.6))
                    .clipShape(Circle())
            }
            .padding(.top, closeButtonTopPadding)
            .padding(.leading, 12)
        }
        .fullScreenCover(isPresented: $showTrailerView) {
            TrailerView(
                device: device,
                selectedDefects: []
            )
            .background(
                RoundedCorners(color: .white, tl: 12, tr: 12, bl: 0, br: 0)
                    .edgesIgnoringSafeArea(.bottom)
            )
            .presentationDetents([.fraction(0.7)])
        }
    }
    
    private var leadingPadding: CGFloat {
        switch device {
        case .iPhone: return 16
        case .iPadPortrait: return 24
        case .iPadLandscape: return 40
        }
    }
    private var horizontalPadding: CGFloat { leadingPadding }
    private var titleTopPadding: CGFloat {
        switch device {
        case .iPhone: return 16
        case .iPadPortrait: return 20
        case .iPadLandscape: return 24
        }
    }
    private var buttonBottomPadding: CGFloat {
        switch device {
        case .iPhone: return 16
        case .iPadPortrait: return 32
        case .iPadLandscape: return 40
        }
    }
    private var closeButtonTopPadding: CGFloat {
        switch device {
        case .iPhone: return 52
        case .iPadPortrait: return 70
        case .iPadLandscape: return 80
        }
    }
    private var gridSpacing: CGFloat {
        switch device {
        case .iPhone: return 22
        case .iPadPortrait: return 26
        case .iPadLandscape: return 28
        }
    }
    private var gridColumns: [GridItem] {
        switch device {
        case .iPhone, .iPadPortrait:
            return [GridItem(.flexible(), spacing: gridSpacing),
                    GridItem(.flexible(), spacing: gridSpacing)]
        case .iPadLandscape:
            return [GridItem(.flexible(), spacing: gridSpacing),
                    GridItem(.flexible(), spacing: gridSpacing),
                    GridItem(.flexible(), spacing: gridSpacing)]
        }
    }
    private var buttonWidth: CGFloat { device == .iPhone ? 100 : 200 }
    private var buttonHeight: CGFloat { device == .iPhone ? 44 : 48 }
    private var buttonSpacing: CGFloat {
        switch device {
        case .iPhone: return 16
        case .iPadPortrait: return 24
        case .iPadLandscape: return 32
        }
    }
}

struct RoundedCorners: View {
    var color: Color = .white
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let w = geometry.size.width
                let h = geometry.size.height
                
                path.move(to: CGPoint(x: 0, y: tl))
                path.addQuadCurve(to: CGPoint(x: tl, y: 0), control: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: w - tr, y: 0))
                path.addQuadCurve(to: CGPoint(x: w, y: tr), control: CGPoint(x: w, y: 0))
                path.addLine(to: CGPoint(x: w, y: h - br))
                path.addQuadCurve(to: CGPoint(x: w - br, y: h), control: CGPoint(x: w, y: h))
                path.addLine(to: CGPoint(x: bl, y: h))
                path.addQuadCurve(to: CGPoint(x: 0, y: h - bl), control: CGPoint(x: 0, y: h))
                path.addLine(to: CGPoint(x: 0, y: tl))
            }
            .fill(color)
        }
    }
}
