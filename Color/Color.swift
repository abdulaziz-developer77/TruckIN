//
//  Color.swift
//  TruckIn
//
//  Created by Abdulaziz Boyqoziyev  on 8/2/25.
//

import Foundation
import SwiftUICore

extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}
extension Color {
    
    static let bgWhite = Color.white
    static let titleWhite = Color.white
    static let titleBlack = Color(hex: 0x1E1E1E)
    static let borderColorBlack10 = Color(hex: 0xE8E8E8)
//    rgba(8, 145, 178, 1)
    static let primary100 = Color(hex: 0x0891B2)
    static let primary90 = Color(hex: 0x219CBA)
    static let primary80 = Color(hex: 0x39A7C1)
    static let primary70 = Color(hex: 0x52B2C9)
    static let primary60 = Color(hex: 0x6BBDD1)
    static let primary50 = Color(hex: 0x83C8D9)
    static let primary40 = Color(hex: 0x9CD3E0)
    static let primary30 = Color(hex: 0xB5DEE8)
    static let primary20 = Color(hex: 0xCEE9F0)
    static let primary10 = Color(hex: 0xE6F4F7)
    
    //rgba(30, 30, 30, 1)
    static let black100 = Color(hex: 0x1E1E1E)
    static let black90 = Color(hex: 0x353535)
    static let black80 = Color(hex: 0x4B4B4B)
    static let black70 = Color(hex: 0x626262)
    static let black60 = Color(hex: 0x787878)
    static let black50 = Color(hex: 0x8E8E8E)
    static let black40 = Color(hex: 0xA5A5A5)
    static let black30 = Color(hex: 0xBBB000)
    static let black20 = Color(hex: 0xD2D2D2)
    static let black10 = Color(hex: 0xE8E8E8)
        
    //rgba(67, 140, 221, 1)
    static let blue100 = Color(hex: 0x438CDD)
    static let blue90 = Color(hex: 0x5697E0)
    static let blue80 = Color(hex: 0x69A3E4)
    static let blue70 = Color(hex: 0x7BAFE7)
    static let blue60 = Color(hex: 0x8EBAEB)
    static let blue50 = Color(hex: 0xA1C5EE)
    static let blue40 = Color(hex: 0xB4D1F1)
    static let blue30 = Color(hex: 0xC7DDF5)
    static let blue20 = Color(hex: 0xD9E8F8)
    static let blue10 = Color(hex: 0xECF3FC)
    
    //rgba(65, 183, 71, 1)
    static let green100 = Color(hex: 0x41B747)
    static let green90 = Color(hex: 0x54BE59)
    static let green80 = Color(hex: 0x67C56C)
    static let green70 = Color(hex: 0x7ACD7E)
    static let green60 = Color(hex: 0x8DD491)
    static let green50 = Color(hex: 0xA0DBA3)
    static let green40 = Color(hex: 0xB3E2B5)
    static let green30 = Color(hex: 0xC6E9C8)
    static let green20 = Color(hex: 0xD9F1DA)
    static let green10 = Color(hex: 0xECF8ED)
    
//    rgba(233, 170, 37, 1)
    static let orange100 = Color(hex: 0xE9AA25)
    static let orange90 = Color(hex: 0xEBB33B)
    static let orange80 = Color(hex: 0xEDBB51)
    static let orange70 = Color(hex: 0xF0C366)
    static let orange60 = Color(hex: 0xF2CC7C)
    static let orange50 = Color(hex: 0xF4D592)
    static let orange40 = Color(hex: 0xF6DDA8)
    static let orange30 = Color(hex: 0xF8E5BE)
    static let orange20 = Color(hex: 0xFBEED3)
    static let orange10 = Color(hex: 0xFDF6E9)
    
//    rgba(226, 80, 80, 1)
    static let red100 = Color(hex: 0xE25050)
    static let red90 = Color(hex: 0xE56262)
    static let red80 = Color(hex: 0xE87373)
    static let red70 = Color(hex: 0xEB8484)
    static let red60 = Color(hex: 0xEE9696)
    static let red50 = Color(hex: 0xF1A7A7)
    static let red40 = Color(hex: 0xF3B9B9)
    static let red30 = Color(hex: 0xF6CACA)
    static let red20 = Color(hex: 0xF9DCDC)
    static let red10 = Color(hex: 0xFCEDED)
    
//    rgba(125, 138, 155, 1)
    static let gray100 = Color(hex: 0x7D8A9B)
    static let gray90 = Color(hex: 0x7D8A9B)
    static let gray80 = Color(hex: 0x8B97A6)
    static let gray70 = Color(hex: 0x99A4B1)
    static let gray60 = Color(hex: 0xA8B1BC)
    static let gray50 = Color(hex: 0xB6BEC7)
    static let gray40 = Color(hex: 0xC5CBD3)
    static let gray30 = Color(hex: 0xD3D8DE)
    static let gray20 = Color(hex: 0xE2E5E9)
    static let gray10 = Color(hex: 0xF0F2F4)
}
