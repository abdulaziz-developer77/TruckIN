//
//  CreateDVIRTextField.swift
//  TruckIn
//
//  Created by Abdulaziz Boyqoziyev  on 8/1/25.
//


import SwiftUI
import PhotosUI


struct CreateDVIRTextField: View {
    @Binding var showSignatureSheet: Bool
    @Binding var signatureImage: UIImage?

    @State private var vehicle = ""
    @State private var date = ""
    @State private var location = ""
    @State private var odometer = ""
    @State private var trailer = ""

    @State private var defectText = ""
    @State private var defects: [String] = []

    @State private var trailerText = ""
    @State private var trailerDefects: [String] = []

    @State private var truckImages: [UIImage] = []
    @State private var trailerImages: [UIImage] = []

    @State private var showValidationError = false

    @State private var showModal = false
    
    private var isIpad: Bool { UIDevice.current.userInterfaceIdiom == .pad }
    private var isLandscape: Bool { UIScreen.main.bounds.width > UIScreen.main.bounds.height }

    private var fieldPadding: CGFloat {
        if isIpad {
            return isLandscape ? 242 : 54
        } else {
            return 16
        }
    }

    private var tagViewInnerSpacing: CGFloat { 10 }
    private var buttonSpacing: CGFloat { isIpad ? 24 : 12 }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                labeledField("Vehicle", text: $vehicle)
                labeledField("Date", text: $date)
                labeledField("Location", text: $location)
                labeledField("Odometer", text: $odometer)
                labeledField("Trailer", text: $trailer)

                if isIpad && isLandscape {
                   
                    HStack(alignment: .top, spacing: tagViewInnerSpacing) {
                        TagInputView(
                            tags: $defects,
                            newTag: $defectText,
                            leadingPadding: 8,
                            trailingPadding: 8
                        )
                        .frame(maxWidth: .infinity)

                        TagInputView(
                            tags: $trailerDefects,
                            newTag: $trailerText,
                            leadingPadding: 8,
                            trailingPadding: 8
                        )
                        .frame(maxWidth: .infinity)
                    }
                    .padding(.horizontal, fieldPadding)
                } else {
                    VStack(spacing: 16) {
                        TagInputView(tags: $defects, newTag: $defectText, leadingPadding: fieldPadding, trailingPadding: fieldPadding)
                        TagInputView(tags: $trailerDefects, newTag: $trailerText, leadingPadding: fieldPadding, trailingPadding: fieldPadding)
                    }
                    .padding(.horizontal, isIpad ? 0 : 0)
                }

                VStack(spacing: 16) {
                    MultiImagePickerView(selectedImages: $truckImages, maxSelection: 3, title: "Truck Images", horizontalPadding: fieldPadding)
                        .frame(maxWidth: .infinity)
                    MultiImagePickerView(selectedImages: $trailerImages, maxSelection: 3, title: "Trailer Images", horizontalPadding: fieldPadding)
                        .frame(maxWidth: .infinity)
                }
                .padding(.horizontal, 0)
                signatureSection

                actionButtons
                    .padding(.horizontal, fieldPadding)
            }
            .padding(.vertical)
        }
    }

  
    private var signatureSection: some View {
        Group {
            Text("Signature")
                .font(.headline)
                .padding(.horizontal, fieldPadding)

            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(showValidationError && signatureImage == nil ? Color.red : Color.gray.opacity(0.3), lineWidth: 1)
                    .frame(height: 280)
                    .background(Color(.systemGray6))

                if let image = signatureImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: signatureWidth,
                        height: 280
                        )
                        .cornerRadius(20)
                } else {
                    Text("Tap to sign")
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal, fieldPadding)
            .onTapGesture { withAnimation { showSignatureSheet = true } }
        }
    }
    private var actionButtons: some View {
        HStack(spacing: buttonSpacing) {
            
            Button(action: {}) {
                if isIpad {
                    HStack {
                        Image(systemName: "pencil")
                        Text("Edit")
                    }
                } else {
                    Image(systemName: "pencil")
                }
            }
            .frame(width: buttonSize.width, height: buttonSize.height)
            .background(Color.primary50)
            .foregroundColor(.white)
            .cornerRadius(12)
            
            Button(action: { resetForm() }) {
                if isIpad {
                    HStack {
                        Image(systemName: "trash")
                        Text("Delete")
                    }
                } else {
                    Image(systemName: "trash")
                }
            }
            .frame(width: buttonSize.width, height: buttonSize.height)
            .background(isFormValid ? Color.red : Color.red100.opacity(0.2))
            .foregroundColor(.white)
            .cornerRadius(12)
            .disabled(!isFormValid)
            
            Spacer()
            
            Button(action: { showModal = true }) {
                Text("Save")
                    .frame(width: saveButtonSize.width, height: saveButtonSize.height)
                    .background(Color.primary50)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .fullScreenCover(isPresented: $showModal) {
                let deviceType: DeviceType = {
                    if UIDevice.current.userInterfaceIdiom == .pad {
                        return UIScreen.main.bounds.width > UIScreen.main.bounds.height ? .iPadLandscape : .iPadPortrait
                    } else {
                        return .iPhone
                    }
                }()

                ZStack(alignment: .topLeading) {
                    TruckDefectsView(device: deviceType)
                }
            }
        }
    }

    private var buttonSize: (width: CGFloat, height: CGFloat) {
        if isIpad { return isLandscape ? (180, 60) : (160, 55) } else { return (50, 50) }
    }
    private var saveButtonSize: (width: CGFloat, height: CGFloat) {
        if isIpad { return isLandscape ? (200, 60) : (180, 55) } else { return (120, 45) }
    }

    private var isFormValid: Bool {
        !vehicle.isEmpty &&
        !date.isEmpty &&
        !location.isEmpty &&
        !odometer.isEmpty &&
        !trailer.isEmpty &&
        !defects.isEmpty &&
        !trailerDefects.isEmpty &&
        !truckImages.isEmpty &&
        !trailerImages.isEmpty &&
        signatureImage != nil
    }

    private func resetForm() {
        vehicle = ""; date = ""; location = ""; odometer = ""; trailer = ""
        defectText = ""; defects = []; trailerText = ""; trailerDefects = []
        truckImages = []; trailerImages = []; signatureImage = nil; showValidationError = false
    }

    @ViewBuilder
    private func labeledField(_ label: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .foregroundColor(showValidationError && text.wrappedValue.isEmpty ? .red : .gray)
                .font(.subheadline)
                .padding(.horizontal, fieldPadding)

            TextField(label, text: text)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(showValidationError && text.wrappedValue.isEmpty ? Color.red : Color.gray.opacity(0.3), lineWidth: 1)
                )
                .padding(.horizontal, fieldPadding)
        }
    }
    private var signatureWidth: CGFloat {
        if isIpad {
            return isLandscape ? 800 : 696
        } else {
            return 343
        }
    }
       
        private func topInset() -> CGFloat {
            #if os(iOS)
            if UIDevice.current.userInterfaceIdiom == .pad {
                return 80
            } else {
                return 104
            }
            #else
            return 104
            #endif
        }

      
        struct RoundedCornerShape: Shape {
            var radius: CGFloat = 10
            var corners: UIRectCorner = .allCorners
            
            func path(in rect: CGRect) -> Path {
                let path = UIBezierPath(
                    roundedRect: rect,
                    byRoundingCorners: corners,
                    cornerRadii: CGSize(width: radius, height: radius)
                )
                return Path(path.cgPath)
            }
        }
}






