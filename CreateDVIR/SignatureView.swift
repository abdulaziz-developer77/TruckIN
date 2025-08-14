//
//  SignatureView.swift
//  TruckIn
//
//  Created by Abdulaziz Boyqoziyev  on 8/7/25.
//

import SwiftUI

struct SignatureView: View {
    @Binding var showSignatureSheet: Bool
    @Binding var signatureImage: UIImage?

    @State private var currentDrawing: [CGPoint] = []
    @State private var drawings: [[CGPoint]] = []

    var body: some View {
        VStack(spacing: 16) {
            // Header
            HStack {
                Text("My Signature")
                    .font(.headline)
                    .foregroundColor(.primary)
                Spacer()
                Button(action: { showSignatureSheet = false }) {
                    Image(systemName: "xmark")
                        .font(.headline)
                        .foregroundColor(.primary)
                        .padding(8)
                        .background(Color.gray.opacity(0.2))
                        .clipShape(Circle())
                }
            }
            .padding(.horizontal, 16)
            ZStack {
                VStack(spacing: 0) {
                    Rectangle()
                        .fill(Color.gray.opacity(0.5))
                        .frame(height: 1)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, -horizontalMargin)
                    
                    Canvas { context, size in
                        for path in drawings {
                            var pathObj = Path()
                            if let first = path.first {
                                pathObj.move(to: first)
                                for point in path.dropFirst() {
                                    pathObj.addLine(to: point)
                                }
                                context.stroke(pathObj, with: .color(.black), lineWidth: 2)
                            }
                        }
                        
                        var currentPath = Path()
                        if let first = currentDrawing.first {
                            currentPath.move(to: first)
                            for point in currentDrawing.dropFirst() {
                                currentPath.addLine(to: point)
                            }
                            context.stroke(currentPath, with: .color(.black), lineWidth: 2)
                        }
                    }
                    .gesture(
                        DragGesture(minimumDistance: 0.1)
                            .onChanged { value in currentDrawing.append(value.location) }
                            .onEnded { _ in
                                drawings.append(currentDrawing)
                                currentDrawing = []
                            }
                    )
                    .frame(height: 280)
                    
                    Rectangle()
                        .fill(Color.gray.opacity(0.5))
                        .frame(height: 1)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, -horizontalMargin)
                }
            }

            .frame(height: 280)
            .padding(.horizontal, 16)

            HStack(spacing: 16) {
                Button("Cancel") {
                    showSignatureSheet = false
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)

                Button("Submit") {
                    let image = renderSignatureImage()
                    signatureImage = image
                    showSignatureSheet = false
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.teal)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding(.horizontal, 16)
        }
        .padding(.vertical, 16)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
        .padding(.horizontal, horizontalMargin)
    }
    
    private var horizontalMargin: CGFloat {
        let isIpad = UIDevice.current.userInterfaceIdiom == .pad
        let isLandscape = UIScreen.main.bounds.width > UIScreen.main.bounds.height
        
        if isIpad {
            return isLandscape ? 370 : 110
        } else {
            return 16
        }
    }

    private func renderSignatureImage() -> UIImage {
        let isIpad = UIDevice.current.userInterfaceIdiom == .pad
        let isLandscape = UIScreen.main.bounds.width > UIScreen.main.bounds.height
        
        let size: CGSize
        if isIpad {
            size = isLandscape ? CGSize(width: 800, height: 280) : CGSize(width: 696, height: 280)
        } else {
            size = CGSize(width: 343, height: 280)
        }
        
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { context in
            UIColor.white.setFill()
            context.fill(CGRect(origin: .zero, size: size))
            
            let path = UIBezierPath()
            var minX = CGFloat.infinity, minY = CGFloat.infinity
            var maxX: CGFloat = 0, maxY: CGFloat = 0
            
            for line in drawings {
                for point in line {
                    minX = min(minX, point.x)
                    minY = min(minY, point.y)
                    maxX = max(maxX, point.x)
                    maxY = max(maxY, point.y)
                }
            }
            
            let offsetX = (size.width - (maxX - minX)) / 2 - minX
            let offsetY = (size.height - (maxY - minY)) / 2 - minY
            
            for line in drawings {
                guard let first = line.first else { continue }
                path.move(to: CGPoint(x: first.x + offsetX, y: first.y + offsetY))
                for point in line.dropFirst() {
                    path.addLine(to: CGPoint(x: point.x + offsetX, y: point.y + offsetY))
                }
            }
            
            UIColor.black.setStroke()
            path.lineWidth = 2
            path.stroke()
        }
    }
}



