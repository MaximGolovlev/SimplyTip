//
//  ColorSchemeManager.swift
//  SimplyTip
//
//  Created by Maxim Golovlev on 22.08.2025.
//


import SwiftUI

final class ColorSchemeManager: ObservableObject {
    static let shared = ColorSchemeManager()
    
    @Published var primaryColor: Color = .green
    @Published var secondaryColor: Color = .white
    @Published var backgroundColor: Color = .black
    @Published var accentColor: Color = .blue
    @Published var buttonTextColor: Color = .blue
    
    @Published var backgroundGradient: LinearGradient = LinearGradient(
        gradient: Gradient(colors: [
            Color(red: 0.05, green: 0.05, blue: 0.05),
            Color(red: 0.85, green: 0.9, blue: 1.0)]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    private init() {
        setupNeonBlueScheme()
    }
    
    func setupNeonGreenScheme() {
        primaryColor = Color(red: 0.0, green: 1.0, blue: 0.0) // Неоново-зеленый
        secondaryColor = .white
        backgroundColor = Color(red: 0.05, green: 0.05, blue: 0.05) // Темный фон
        accentColor = Color(red: 0.2, green: 0.8, blue: 0.2)
    }
    
    func setupNeonBlueScheme() {
        primaryColor = Color(red: 0.0, green: 0.8, blue: 1.0)       // Яркий неоново-синий
        secondaryColor = Color(red: 0.8, green: 0.9, blue: 1.0)     // Светло-голубой
        backgroundColor = Color(red: 0.08, green: 0.08, blue: 0.12) // Глубокий темно-синий
        accentColor = Color(red: 0.2, green: 0.6, blue: 1.0)        // Акцентный синий
        buttonTextColor = Color(red: 0.05, green: 0.05, blue: 0.08) // Очень темный синий
        
        backgroundGradient = LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 0.08, green: 0.08, blue: 0.12),
                Color(red: 0.15, green: 0.15, blue: 0.25)
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    func setupNeonPinkScheme() {
        primaryColor = Color(red: 1.0, green: 0.0, blue: 0.8)       // Яркий неоново-розовый
        secondaryColor = Color(red: 1.0, green: 0.8, blue: 0.9)     // Светло-розовый
        backgroundColor = Color(red: 0.12, green: 0.08, blue: 0.1)  // Темно-пурпурный
        accentColor = Color(red: 1.0, green: 0.4, blue: 0.7)        // Акцентный розовый
        
        backgroundGradient = LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 0.12, green: 0.08, blue: 0.1),
                Color(red: 0.25, green: 0.15, blue: 0.2)
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    func setupNeonPurpleScheme() {
        primaryColor = Color(red: 0.8, green: 0.0, blue: 1.0)       // Яркий неоново-фиолетовый
        secondaryColor = Color(red: 0.9, green: 0.8, blue: 1.0)     // Светло-лавандовый
        backgroundColor = Color(red: 0.1, green: 0.08, blue: 0.12)  // Темно-фиолетовый
        accentColor = Color(red: 0.6, green: 0.2, blue: 1.0)        // Акцентный фиолетовый
        
        backgroundGradient = LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 0.1, green: 0.08, blue: 0.12),
                Color(red: 0.2, green: 0.15, blue: 0.25)
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    func setupCyberpunkScheme() {
        primaryColor = Color(red: 0.0, green: 1.0, blue: 1.0)       // Неоновый голубой
        secondaryColor = Color(red: 1.0, green: 0.0, blue: 1.0)     // Неоновый пурпурный
        backgroundColor = Color(red: 0.08, green: 0.06, blue: 0.1)  // Очень темный фиолетовый
        accentColor = Color(red: 0.5, green: 1.0, blue: 1.0)        // Акцентный бирюзовый
        
        backgroundGradient = LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 0.08, green: 0.06, blue: 0.1),
                Color(red: 0.2, green: 0.1, blue: 0.3)
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    func setupCustomScheme(primary: Color, secondary: Color, background: Color, accent: Color) {
        primaryColor = primary
        secondaryColor = secondary
        backgroundColor = background
        accentColor = accent
    }
}
