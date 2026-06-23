//
//  Color+Theme.swift
//  BiteMe
//
//  Created by Andrew King on 10/15/25.
//

import SwiftUI

extension Color {
    static let cream = Color(hex: 0xFDF8F3)
    static let terracotta = Color(hex: 0xD2691E)
    static let herbGreen = Color(hex: 0x5C7A4A)
    static let mustard = Color(hex: 0xE8A33D)
    static let tomato = Color(hex: 0xC1440E)
    static let coffee = Color(hex: 0x3E2C23)
}

extension Color {
    init(hex: UInt, alpha: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0,
            opacity: alpha
        )
    }
}
