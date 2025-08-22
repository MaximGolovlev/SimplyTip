//
//  SettingsView.swift
//  SimplyTip
//
//  Created by Maxim Golovlev on 22.08.2025.
//


import SwiftUI

struct SettingsView: View {
    @StateObject private var settingsManager = SettingsManager.shared
    @StateObject private var colorManager = ColorSchemeManager.shared
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
    
        NavigationView {
            
            ZStack {
                
                colorManager.backgroundGradient
                    .ignoresSafeArea()
                
                Form {
                    
                    currencySection
                    mainSettingsSection
                    
                    Section {
                        Button("Reset to Defaults") {
                            settingsManager.resetToDefaults()
                        }
                        .foregroundColor(.red)
                    }
                    .listRowBackground(Color.gray.opacity(0.1))
                }
                .navigationTitle("Settings")
                .navigationBarTitleDisplayMode(.large)
                //.background(colorManager.backgroundColor)
                .scrollContentBackground(.hidden)
            }
        }
    }
    
    private var currencySection: some View {
        Section(header: Text("Currency")
            .foregroundColor(colorManager.primaryColor)) {
                
            HStack {
                Text("Selected Currency")
                    .foregroundColor(colorManager.secondaryColor)
                
                Spacer()
                
                Text("\(settingsManager.getCurrencySymbol()) (\(settingsManager.selectedCurrency))")
                    .foregroundColor(colorManager.primaryColor)
                    .fontWeight(.semibold)
            }
            
            CurrencyPicker(
                selectedCurrency: $settingsManager.selectedCurrency,
                currencies: settingsManager.availableCurrencies
            )
            .foregroundColor(colorManager.secondaryColor)
        }
        .listRowBackground(Color.gray.opacity(0.1))
    }
    
    private var mainSettingsSection: some View {
        Section(header: Text("Tip Settings")
            .foregroundColor(colorManager.primaryColor)) {
                
            VStack(alignment: .leading, spacing: 12) {
                Text("Default Tip Percentage: \(Int(settingsManager.defaultTipPercentage))%")
                    .foregroundColor(colorManager.secondaryColor)
                
                Slider(value: $settingsManager.defaultTipPercentage, in: 0...50, step: 1)
                    .accentColor(colorManager.primaryColor)
            }
            .padding(.vertical, 8)
            
            Toggle("Round to nearest", isOn: $settingsManager.roundToNearest)
                .foregroundColor(colorManager.secondaryColor)
                .tint(colorManager.primaryColor)
            
            Toggle("Enable bill splitting", isOn: $settingsManager.splitBillEnabled)
                .foregroundColor(colorManager.secondaryColor)
                .tint(colorManager.primaryColor)
        }
        .listRowBackground(Color.gray.opacity(0.1))
    }
}
