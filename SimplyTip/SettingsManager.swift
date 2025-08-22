//
//  SettingsManager.swift
//  SimplyTip
//
//  Created by Maxim Golovlev on 22.08.2025.
//


import Foundation

final class SettingsManager: ObservableObject {
    static let shared = SettingsManager()
    
    @Published var defaultTipPercentage: Double = 15.0 {
        didSet {
            defaults.set(defaultTipPercentage, forKey: defaultTipKey)
        }
    }
    @Published var roundToNearest: Bool = false {
        didSet {
            defaults.set(roundToNearest, forKey: roundToNearestKey)
        }
    }
    @Published var splitBillEnabled: Bool = true {
        didSet {
            defaults.set(splitBillEnabled, forKey: splitBillKey)
        }
    }
    
    @Published var selectedCurrency: String = "USD" {
        didSet {
            defaults.set(selectedCurrency, forKey: currencyKey)
        }
    }
    
    private let defaults = UserDefaults.standard
    private let defaultTipKey = "defaultTipPercentage"
    private let roundToNearestKey = "roundToNearest"
    private let splitBillKey = "splitBillEnabled"
    private let currencyKey = "selectedCurrency"
    
    // Доступные валюты
    let availableCurrencies: [String] = [
        "USD", "EUR", "GBP", "JPY", "CAD", "AUD", "CHF", "CNY",
        "RUB", "BRL", "INR", "MXN", "KRW", "TRY", "SEK", "NOK"
    ]
    
    private init() {
        loadSettings()
    }
    
    func loadSettings() {
        defaultTipPercentage = defaults.double(forKey: defaultTipKey)
        if defaultTipPercentage == 0 {
            defaultTipPercentage = 15.0
        }
        
        roundToNearest = defaults.bool(forKey: roundToNearestKey)
        splitBillEnabled = defaults.bool(forKey: splitBillKey)
        selectedCurrency = defaults.string(forKey: currencyKey) ?? Locale.current.currency?.identifier ?? "USD"
    }
    
    func resetToDefaults() {
        defaultTipPercentage = 15.0
        roundToNearest = false
        splitBillEnabled = true
        selectedCurrency = Locale.current.currency?.identifier ?? "USD"
    }
    
    func getCurrencySymbol() -> String {
        let locale = Locale(identifier: Locale.identifier(fromComponents: [NSLocale.Key.currencyCode.rawValue: selectedCurrency]))
        return locale.currencySymbol ?? selectedCurrency
    }
    
    func getCurrencyName() -> String {
        let locale = Locale(identifier: Locale.identifier(fromComponents: [NSLocale.Key.currencyCode.rawValue: selectedCurrency]))
        return locale.localizedString(forCurrencyCode: selectedCurrency) ?? selectedCurrency
    }
}
