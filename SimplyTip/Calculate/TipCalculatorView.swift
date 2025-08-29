//
//  TipCalculatorView.swift
//  SimplyTip
//
//  Created by Maxim Golovlev on 22.08.2025.
//


import SwiftUI

struct TipCalculatorView: View {
    @StateObject private var viewModel = TipCalculatorViewModel()
    @EnvironmentObject private var colorManager: ColorSchemeManager
    @EnvironmentObject private var settingsManager: SettingsManager
    
    var body: some View {
        NavigationView {
            ZStack {
                colorManager.backgroundGradient
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    // Заголовок
                    header
                    
                    // Поле ввода счета
                    billInputSection
                    
                    // Проценты чаевых
                    tipPercentageSection
                    
                    // Разделение счета
                    if settingsManager.splitBillEnabled {
                        splitBillSection
                    }
                    
                    // Результаты
                    resultsSection
                    
                    Spacer()
                }
                .padding()
            }
            .onAppear {
                viewModel.update(settingsManager: settingsManager)
            }
            .onTapGesture {
                hideKeyboard()
            }
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    private var header: some View {
        VStack(alignment: .center, spacing: 8) {
            Text("Tip Calculator")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(colorManager.primaryColor)
            
            Text(settingsManager.selectedCurrency)
                .font(.caption)
                .foregroundColor(colorManager.secondaryColor.opacity(0.7))
                .padding(.top, -5)
        }
    }
    
    private var billInputSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Bill Amount")
                .font(.headline)
                .foregroundColor(colorManager.secondaryColor)
            
            HStack {
                Text(settingsManager.getCurrencySymbol())
                    .font(.title2)
                    .foregroundColor(colorManager.primaryColor)
                
                TextField("0.00", text: $viewModel.billAmount)
                    .keyboardType(.decimalPad)
                    .font(.title2)
                    .foregroundColor(colorManager.secondaryColor)
                    .padding(8)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .onChange(of: viewModel.billAmount) { newValue in
                        // Фильтруем ввод - только цифры и одна точка
                        viewModel.billAmount = filterDecimalInput(newValue)
                    }
            }
        }
    }
    
    private func filterDecimalInput(_ input: String) -> String {
        var filtered = input.filter { "0123456789.,".contains($0) }
        
        // Заменяем запятые на точки
        filtered = filtered.replacingOccurrences(of: ",", with: ".")
        
        // Убеждаемся, что есть только одна точка
        let components = filtered.split(separator: ".", omittingEmptySubsequences: false)
        if components.count > 2 {
            // Если больше одной точки, оставляем только первую
            let firstPart = String(components[0])
            let secondPart = components.dropFirst().joined(separator: "")
            filtered = firstPart + "." + secondPart
        }
        
        // Ограничиваем двумя знаками после запятой
        if let dotIndex = filtered.firstIndex(of: ".") {
            let decimalPart = filtered[filtered.index(after: dotIndex)...]
            if decimalPart.count > 2 {
                filtered = String(filtered.prefix(upTo: filtered.index(dotIndex, offsetBy: 3)))
            }
        }
        
        return filtered
    }
    
    private var tipPercentageSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            Divider()
                .background(colorManager.secondaryColor.opacity(0.3))
            
            Text("Tip Percentage: \(Int(settingsManager.defaultTipPercentage))%")
                .font(.headline)
                .foregroundColor(colorManager.secondaryColor)
            
            Slider(value: $settingsManager.defaultTipPercentage, in: 0...50, step: 1)
                .accentColor(colorManager.primaryColor)
            
            HStack(spacing: 15) {
                ForEach([10, 15, 18, 20], id: \.self) { percentage in
                    Button(action: {
                        viewModel.quickTipPercentage(Double(percentage))
                        hideKeyboard()
                    }) {
                        Text("\(percentage)%")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(colorManager.buttonTextColor)
                            .padding(8)
                            .background(
                                settingsManager.defaultTipPercentage == Double(percentage) ?
                                colorManager.primaryColor : Color.gray.opacity(0.3)
                            )
                            .cornerRadius(8)
                    }
                }
            }
        }
    }
    
    private var splitBillSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            Divider()
                .background(colorManager.secondaryColor.opacity(0.3))
            
            Text("Split Bill")
                .font(.headline)
                .foregroundColor(colorManager.secondaryColor)
            
            HStack {
                Button(action: {
                    viewModel.decrementPeople()
                }) {
                    Image(systemName: "minus.circle.fill")
                        .font(.title2)
                        .foregroundColor(colorManager.primaryColor)
                }
                
                Text("\(viewModel.numberOfPeople) person(s)")
                    .font(.title3)
                    .foregroundColor(colorManager.secondaryColor)
                    .frame(minWidth: 120)
                
                Button(action: {
                    viewModel.incrementPeople()
                }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                        .foregroundColor(colorManager.primaryColor)
                }
            }
        }
    }
    
    private var resultsSection: some View {
        VStack(spacing: 16) {
            ResultRow(
                title: "Tip Amount:",
                amount: viewModel.tipAmount,
                currencySymbol: settingsManager.getCurrencySymbol(),
                color: colorManager.primaryColor
            )
            
            ResultRow(
                title: "Total Amount:",
                amount: viewModel.totalAmount,
                currencySymbol: settingsManager.getCurrencySymbol(),
                color: colorManager.accentColor
            )
            
            if settingsManager.splitBillEnabled {
                Divider()
                    .background(colorManager.secondaryColor.opacity(0.3))
                
                ResultRow(
                    title: "Per Person:",
                    amount: viewModel.amountPerPerson,
                    currencySymbol: settingsManager.getCurrencySymbol(),
                    color: colorManager.primaryColor
                )
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}

struct ResultRow: View {
    let title: String
    let amount: Double
    let currencySymbol: String
    let color: Color
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.white)
                .font(.headline)
            
            Spacer()
            
            Text(formatCurrency(amount))
                .foregroundColor(color)
                .font(.title3)
                .fontWeight(.bold)
        }
    }
    
    private func formatCurrency(_ amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = currencySymbol
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        return formatter.string(from: NSNumber(value: amount)) ?? "\(currencySymbol)\(amount)"
    }
}
