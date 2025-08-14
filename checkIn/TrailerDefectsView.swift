//
//  TrailerDefectsView.swift
//  TruckIn
//
//  Created by Abdulaziz Boyqoziyev  on 8/14/25.
//

import SwiftUI

struct TrailerView: View {
    var device: DeviceType
    var selectedDefects: [String]
    
    @State private var defects: [String: Bool] = [:]
    @Environment(\.presentationMode) var presentationMode
    
    init(device: DeviceType, selectedDefects: [String]) {
        self.device = device
        self.selectedDefects = selectedDefects
        
        var dict: [String: Bool] = [
            "Tire issue": false, "No issue": false, "Brakes": false, "Doors": false,
            "Hitch": false, "Lights": false, "Roots": false, "Landing Gear": false,
            "Wheel and Rims": false, "Mudflaps": false
        ]
        
        for defect in selectedDefects { dict[defect] = true }
        _defects = State(initialValue: dict)
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 0) {
                Text("Trailer defects")
                    .font(.system(size: 22, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, leadingPadding)
                    .padding(.top, titleTopPadding)
                
                Divider()
                    .frame(height: 1)
                    .background(Color.gray.opacity(0.4))
                    .padding(.horizontal, leadingPadding)
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
                    .padding(.horizontal, leadingPadding)
                    .padding(.top, 16)
                    .padding(.bottom, 16)
                }
                
                Divider()
                    .frame(height: 1)
                    .background(Color.black.opacity(0.1))
                    .padding(.horizontal, leadingPadding)
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
                    
                    Button(action: {}) {
                        Text("Save")
                            .fontWeight(.semibold)
                            .frame(width: buttonWidth, height: buttonHeight)
                            .background(Color.primary100)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                }
                .padding(.horizontal, leadingPadding)
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
    }
    
    private var leadingPadding: CGFloat {
        switch device { case .iPhone: return 16; case .iPadPortrait: return 24; case .iPadLandscape: return 52 }
    }
    private var titleTopPadding: CGFloat {
        switch device { case .iPhone: return 16; case .iPadPortrait: return 20; case .iPadLandscape: return 24 }
    }
    private var buttonBottomPadding: CGFloat {
        switch device { case .iPhone: return 16; case .iPadPortrait: return 32; case .iPadLandscape: return 28 }
    }
    private var closeButtonTopPadding: CGFloat {
        switch device { case .iPhone: return 52; case .iPadPortrait: return 70; case .iPadLandscape: return 80 }
    }
    private var gridSpacing: CGFloat {
        switch device { case .iPhone: return 22; case .iPadPortrait: return 26; case .iPadLandscape: return 28 }
    }
    private var gridColumns: [GridItem] {
        switch device {
        case .iPhone, .iPadPortrait:
            return [GridItem(.flexible(), spacing: gridSpacing), GridItem(.flexible(), spacing: gridSpacing)]
        case .iPadLandscape:
            return [GridItem(.flexible(), spacing: gridSpacing), GridItem(.flexible(), spacing: gridSpacing), GridItem(.flexible(), spacing: gridSpacing)]
        }
    }
    private var buttonWidth: CGFloat { device == .iPhone ? 100 : 200 }
    private var buttonHeight: CGFloat { device == .iPhone ? 44 : 48 }
    private var buttonSpacing: CGFloat {
        switch device { case .iPhone: return 16; case .iPadPortrait: return 24; case .iPadLandscape: return 32 }
    }
}
