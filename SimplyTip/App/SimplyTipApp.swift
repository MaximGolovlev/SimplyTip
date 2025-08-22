//
//  SimplyTipApp.swift
//  SimplyTip
//
//  Created by Maxim Golovlev on 22.08.2025.
//

import SwiftUI

@main
struct SimplyTipApp: App {
    @StateObject private var colorManager = ColorSchemeManager.shared
    @StateObject private var settingsManager = SettingsManager.shared
    
    var body: some Scene {
        WindowGroup {
            TabView {
                Tab("Calculate", systemImage: "percent") {
                    TipCalculatorView()
                }
                
                Tab("Sttings", systemImage: "gearshape.fill") {
                    SettingsView()
                }
            }
            .accentColor(colorManager.primaryColor)
            .environmentObject(colorManager)
            .environmentObject(settingsManager)
            .preferredColorScheme(.dark) // Темная тема по умолчанию
        }
    }
}
