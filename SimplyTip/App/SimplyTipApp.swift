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
                TipCalculatorView()
                    .tabItem {
                        Label("Calculate", systemImage: "percent")
                    }
                
                SettingsView()
                    .tabItem {
                        Label("Sttings", systemImage: "gearshape.fill")
                    }
            }
            .tint(colorManager.primaryColor)
            .environmentObject(colorManager)
            .environmentObject(settingsManager)
            .preferredColorScheme(.dark) // Темная тема по умолчанию
        }
    }
}
