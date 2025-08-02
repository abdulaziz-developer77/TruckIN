//
//  CreateDVIRTextField.swift
//  TruckIn
//
//  Created by Abdulaziz Boyqoziyev  on 8/1/25.
//

import SwiftUI



//struct CreateDVIRTextField: View {
//    @State private var vehicle = ""
//    @State private var trailer = ""
//    @State private var location = ""
//    @State private var odometer = ""
//    
//    @State private var defects1: [String] = [""]
//    @State private var defects2: [String] = [""]
//    
//    var body: some View {
//                ScrollView {
//                    VStack(spacing: 16) {
//                        // TextFields
//                        LabeledTextField(label: "Vehicle", placeholder: "Enter vehicle", text: $vehicle)
//                        LabeledTextField(label: "Trailer", placeholder: "Enter trailer", text: $trailer)
//                        LabeledTextField(label: "Location", placeholder: "Enter location", text: $location)
//                        LabeledTextField(label: "Odometer", placeholder: "Enter odometer", text: $odometer)
//                        
//                        // Expandable Sections
//                        ExpandableTextFields(label: "Defects - External", placeholder: "Enter defect", items: $defects1)
//                        ExpandableTextFields(label: "Defects - Internal", placeholder: "Enter defect", items: $defects2)
//                    }
//                    .padding(.vertical)
//                }
//            }
//          
//        }
//    
//
//struct LabeledTextField: View {
//    let label: String
//    let placeholder: String
//    @Binding var text: String
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 4) {
//            Text(label)
//                .font(.system(size: 14, weight: .semibold))
//                .foregroundColor(.gray)
//            
//            TextField(placeholder, text: $text)
//                .padding()
//                .background(Color.white)
//                .cornerRadius(12)
//                .overlay(
//                    RoundedRectangle(cornerRadius: 12)
//                        .stroke(Color.gray.opacity(0.4), lineWidth: 1)
//                )
//        }
//        .padding(.horizontal, 16)
//    }
//}
//
//
//struct ExpandableTextFields: View {
//    let label: String
//    let placeholder: String
//    @Binding var items: [String]
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            Text(label)
//                .font(.system(size: 14, weight: .semibold))
//                .foregroundColor(.gray)
//                .padding(.horizontal, 16)
//            
//            ForEach(items.indices, id: \.self) { index in
//                HStack {
//                    TextField(placeholder, text: $items[index])
//                        .padding()
//                        .background(Color.white)
//                        .cornerRadius(12)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 12)
//                                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
//                        )
//                    
//                    // Faqat oxirgi TextField ichida + button ko‘rinadi
//                    if index == items.count - 1 {
//                        Button(action: {
//                            items.append("")
//                        }) {
//                            Image(systemName: "plus.circle.fill")
//                                .foregroundColor(.blue)
//                                .font(.title2)
//                        }
//                        .padding(.leading, 8)
//                    }
//                }
//                .padding(.horizontal, 16)
//            }
//        }
//    }
//}


import SwiftUI

struct CreateDVIRTextField: View {
    @State private var vehicle = ""
    @State private var date = ""
    @State private var location = ""
    @State private var odometer = ""
    @State private var trailer = ""
    @State private var trailerDefect = ""
    @State private var signature: String = ""
    
    @State private var defects1: [String] = [""]
    @State private var defects2: [String] = [""]
    

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                LabeledTextField(label: "Vehicle", placeholder: "Vehicle", text: $vehicle)
                LabeledTextField(label: "Date", placeholder: "Date", text: $date)
                LabeledTextField(label: "Location", placeholder: "Location", text: $location)
                LabeledTextField(label: "Odometer", placeholder: "Odometer", text: $odometer)
                LabeledTextField(label: "Trailer", placeholder: "Enter trailers", text: $trailer)
               
//                Group {
//                    Text("Truck image")
//                    HStack(spacing: 10) {
//                        ForEach(0..<3) { _ in
//                            VStack {
//                                Image(systemName: "photo.report.image")
////                                    .font(.system(size: 24))
////                                Text("Photo Report")
////                                    .font(.caption)
////                                    .foregroundColor(.teal)
//                            }
//                            .frame(width: 90, height: 90)
//                            .background(Color(.systemGray5))
//                            .cornerRadius(10)
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 10)
//                                    .stroke(Color.blue, style: StrokeStyle(lineWidth: 1, dash: [5]))
//                            )
//                        }
//                    }
//
//                    Text("Trailer image")
//                    HStack(spacing: 10) {
//                        ForEach(0..<3) { _ in
//                            VStack {
//                                Image(systemName: "photo.report.image")
////                                    .font(.system(size: 24))
//                                Text("Photo Report")
//                                    .font(.caption)
//                                    .foregroundColor(.teal)
//                            }
//                            .frame(width: 90, height: 90)
//                            .background(Color(.systemGray5))
//                            .cornerRadius(10)
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 10)
//                                    .stroke(Color.gray.opacity(0.5), style: StrokeStyle(lineWidth: 1, dash: [5]))
//                            )
//                        }
//                    }
//                }

                Group {
                    Text("Sign")
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        .frame(height: 200)
                        .background(Color(.systemGray6))
                        .overlay(Text("✍️ Imzo maydoni").foregroundColor(.gray))
                }

                HStack(spacing: 16) {
                    Button(action: {
                        // Edit
                    }) {
                        Image(systemName: "pencil")
                            .frame(width: 50, height: 50)
                            .background(Color.teal)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }

                    Button(action: {
                        // Delete
                    }) {
                        Image(systemName: "trash")
                            .frame(width: 50, height: 50)
                            .background(Color.red.opacity(0.7))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }

                    Spacer()

                    Button(action: {
                        // Save
                    }) {
                        Text("Save")
                            .frame(width: 100, height: 50)
                            .background(Color.teal.opacity(0.6))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                }
                .padding(.top)
            }
            .padding()
        }
    }
}



struct LabeledTextField: View {
    let label: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
        Text(label)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.gray)
            TextField(placeholder, text: $text)
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                )
                
        }
        .padding(.horizontal, 16)
    }
}
