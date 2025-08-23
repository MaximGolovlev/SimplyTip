//
//  SimplyTipApp.swift
//  SimplyTip
//
//  Created by Maxim Golovlev on 22.08.2025.
//

import SwiftUI

@main
struct SimplyTipApp: App {
    var colorManager = ColorSchemeManager()
    var settingsManager = SettingsManager()
    
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
            .tint(colorManager.primaryColor)
            .environmentObject(colorManager)
            .environmentObject(settingsManager)
            .preferredColorScheme(.dark) // Темная тема по умолчанию
        }
    }
}
