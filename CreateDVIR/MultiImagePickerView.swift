//
//  MultiImagePickerView.swift
//  TruckIn
//
//  Created by Abdulaziz Boyqoziyev  on 8/6/25.
//

import SwiftUI
import PhotosUI

struct MultiImagePickerView: View {
    @Binding var selectedImages: [UIImage]
    @State private var photoItems: [PhotosPickerItem] = []

    @State private var showActionSheet = false
    @State private var showCamera = false
    @State private var showPhotoPicker = false

    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass

    var maxSelection: Int = 3
    var title: String = "Choose Images"
    var horizontalPadding: CGFloat = 16

    private let containerHeight: CGFloat = 138
    private let containerPadding: CGFloat = 10
    private let spacing: CGFloat = 8

    private var placeholderImageName: String {
        if UIDevice.current.userInterfaceIdiom == .pad {
            if horizontalSizeClass == .regular && verticalSizeClass == .compact {
                return "reportimage_ipad_landscape"
            } else {
                return "reportimage_ipad_portrait"
            }
        } else {
            return "reportimage_iphone"
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
                .padding(.horizontal, horizontalPadding)

            GeometryReader { geometry in
                let availableWidth = max(0, geometry.size.width - (horizontalPadding * 2))
                let imageWidth = (availableWidth - (containerPadding * 2) - (spacing * CGFloat(maxSelection - 1))) / CGFloat(maxSelection)

                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(style: StrokeStyle(lineWidth: 1.5, dash: [6, 6]))
                        .foregroundColor(.gray)
                        .frame(height: containerHeight)

                    HStack(spacing: spacing) {
                        ForEach(0..<maxSelection, id: \.self) { index in
                            if index < selectedImages.count {
                                ZStack(alignment: .topTrailing) {
                                    Image(uiImage: selectedImages[index])
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: max(40, imageWidth), height: containerHeight - (containerPadding * 2))
                                        .clipped()
                                        .cornerRadius(10)

                                    Button(action: {
                                        selectedImages.remove(at: index)
                                    }) {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(.red)
                                            .background(Color.white.clipShape(Circle()))
                                    }
                                    .offset(x: 6, y: -6)
                                }
                            } else {
                                Image(placeholderImageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: max(40, imageWidth), height: containerHeight - (containerPadding * 2))
                                    .clipped()
                                    .cornerRadius(10)
                                    .onTapGesture { showActionSheet = true }
                            }
                        }
                    }
                    .padding(containerPadding)
                }
                .padding(.horizontal, horizontalPadding)
            }
            .frame(height: containerHeight + 40)
        }
        .confirmationDialog("Select Option", isPresented: $showActionSheet, titleVisibility: .visible) {
            Button("Camera") { showCamera = true }
            Button("Photo Library") { showPhotoPicker = true }
            Button("Cancel", role: .cancel) {}
        }
        .photosPicker(
            isPresented: $showPhotoPicker,
            selection: $photoItems,
            maxSelectionCount: max(0, maxSelection - selectedImages.count),
            matching: .images
        )
        .onChange(of: photoItems) { newItems in
            for item in newItems {
                Task {
                    if let data = try? await item.loadTransferable(type: Data.self),
                       let image = UIImage(data: data) {
                        selectedImages.append(image)
                    }
                }
            }
            photoItems = []
        }
        .sheet(isPresented: $showCamera) {
            ImagePicker(sourceType: .camera) { image in
                if let image = image {
                    selectedImages.append(image)
                }
            }
        }
    }
}
