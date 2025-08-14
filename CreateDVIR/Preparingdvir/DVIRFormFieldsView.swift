//
//  DVIRFormFieldsView.swift
//  TruckIn
//
//  Created by Abdulaziz Boyqoziyev  on 8/8/25.
//

import SwiftUI


struct DVIRFormFieldsView: View {
    @Binding var vehicle: String
    @Binding var date: String
    @Binding var location: String
    @Binding var odometer: String
    @Binding var trailer: String
    @Binding var defects: [String]
    @Binding var defectText: String
    @Binding var trailerDefects: [String]
    @Binding var trailerText: String
    @Binding var truckImages: [UIImage]
    @Binding var trailerImages: [UIImage]
    var showValidationError: Bool

    var body: some View {
        VStack(spacing: 116) { //
            labeledField("Vehicle", text: $vehicle)
            labeledField("Date", text: $date)
            labeledField("Location", text: $location)
            labeledField("Odometer", text: $odometer)
            labeledField("Trailer", text: $trailer)

            TagInputView(tags: $defects, newTag: $defectText)
            TagInputView(tags: $trailerDefects, newTag: $trailerText)

            MultiImagePickerView(selectedImages: $truckImages, maxSelection: 3, title: "Truck Images")
            MultiImagePickerView(selectedImages: $trailerImages, maxSelection: 3, title: "Trailer Images")
        }
    }

    private func labeledField(_ label: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .foregroundColor(showValidationError && text.wrappedValue.isEmpty ? .red : .gray)
                .font(.subheadline)
                .padding(.horizontal, 106)

            TextField(label, text: text)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(showValidationError && text.wrappedValue.isEmpty ? Color.red : Color.gray.opacity(0.3), lineWidth: 1)
                )
                .padding(.horizontal, 16)
        }
    }
}



