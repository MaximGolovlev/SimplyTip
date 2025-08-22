//
//  NeonButtonStyle.swift
//  SimplyTip
//
//  Created by Maxim Golovlev on 22.08.2025.
//

import SwiftUI

// Создаем модификатор для кнопки
struct NeonButtonStyle: ButtonStyle {
    @EnvironmentObject var colorScheme: ColorSchemeManager
    
    func makeBody(configuration: Configuration) -> some View {
        let textColor = configuration.isPressed ?
            colorScheme.buttonTextColor :
            colorScheme.secondaryColor
        
        print("isPressed: \(configuration.isPressed), color: \(textColor)")
        
        return configuration.label
            .foregroundColor(textColor)
            .background(
                configuration.isPressed ?
                colorScheme.primaryColor.opacity(0.8) :
                colorScheme.primaryColor
            )
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}
