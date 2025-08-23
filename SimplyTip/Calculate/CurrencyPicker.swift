//
//  CurrencyPicker.swift
//  SimplyTip
//
//  Created by Maxim Golovlev on 22.08.2025.
//


import SwiftUI

struct CurrencyPicker: View {
    @Binding var selectedCurrency: String
    let currencies: [String]
    @EnvironmentObject var colorManager: ColorSchemeManager
    
    var body: some View {
        Picker("Currency", selection: $selectedCurrency) {
            ForEach(currencies, id: \.self) { currency in
                HStack {
                    Text(getFlag(for: currency))
                        .font(.title2)
                    Text("\(currency) - \(getCurrencyName(currency))")
                        .foregroundColor(colorManager.secondaryColor)
                }
                .tag(currency)
            }
        }
        .pickerStyle(MenuPickerStyle())
        .tint(colorManager.primaryColor)
    }
    
    private func getFlag(for currencyCode: String) -> String {
        let countryFlags: [String: String] = [
            "USD": "🇺🇸", "EUR": "🇪🇺", "GBP": "🇬🇧", "JPY": "🇯🇵", 
            "CAD": "🇨🇦", "AUD": "🇦🇺", "CHF": "🇨🇭", "CNY": "🇨🇳",
            "RUB": "🇷🇺", "BRL": "🇧🇷", "INR": "🇮🇳", "MXN": "🇲🇽",
            "KRW": "🇰🇷", "TRY": "🇹🇷", "SEK": "🇸🇪", "NOK": "🇳🇴"
        ]
        return countryFlags[currencyCode] ?? "🏳️"
    }
    
    private func getCurrencyName(_ currencyCode: String) -> String {
        let locale = Locale(identifier: Locale.identifier(fromComponents: [NSLocale.Key.currencyCode.rawValue: currencyCode]))
        return locale.localizedString(forCurrencyCode: currencyCode) ?? currencyCode
    }
}
