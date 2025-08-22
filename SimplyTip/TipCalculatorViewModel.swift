//
//  TipCalculatorViewModel.swift
//  SimplyTip
//
//  Created by Maxim Golovlev on 22.08.2025.
//


import Foundation
import Combine

final class TipCalculatorViewModel: ObservableObject {
    @Published var billAmount: String = ""
    @Published var tipPercentage: Double = 15.0
    @Published var numberOfPeople: Int = 1
    
    @Published var splitBillEnabled: Bool = false
    @Published var tipAmount: Double = 0.0
    @Published var totalAmount: Double = 0.0
    @Published var amountPerPerson: Double = 0.0
    
    private var cancellables = Set<AnyCancellable>()
    private let settingsManager = SettingsManager.shared
    
    init() {
        setupBindings()
        loadUserPreferences()
    }
    
    private func setupBindings() {
        
        // Следим за изменениями настроек
        settingsManager.$defaultTipPercentage
        .sink { [weak self] new in
            self?.tipPercentage = new
        }
        .store(in: &cancellables)
        
        settingsManager.$splitBillEnabled
        .sink { [weak self] new in
            self?.splitBillEnabled = new
        }
        .store(in: &cancellables)
        
        Publishers.CombineLatest4(
            $billAmount,
            $tipPercentage,
            $splitBillEnabled,
            $numberOfPeople
        )
        .debounce(for: .seconds(0.1), scheduler: RunLoop.main)
        .sink { [weak self] bill, tip, isSplit, people in
            self?.calculateTips(billAmount: bill, tipPercentage: tip, isSplit: isSplit, numberOfPeople: people)
        }
        .store(in: &cancellables)
    }
    
    private func loadUserPreferences() {
        tipPercentage = settingsManager.defaultTipPercentage
    }
    
    private func calculateTips(billAmount: String, tipPercentage: Double, isSplit: Bool, numberOfPeople: Int) {
        guard let bill = Double(billAmount), bill > 0 else {
            resetCalculations()
            return
        }
        
        var calculatedTip = bill * (tipPercentage / 100)
        var calculatedTotal = bill + calculatedTip
        
        // Округление если включено
        if settingsManager.roundToNearest {
            calculatedTotal = calculatedTotal.rounded()
            calculatedTip = calculatedTotal - bill
        }
        
        let perPerson = numberOfPeople > 0 && isSplit ? calculatedTotal / Double(numberOfPeople) : calculatedTotal
        
        tipAmount = calculatedTip
        totalAmount = calculatedTotal
        amountPerPerson = perPerson
    }
    
    private func resetCalculations() {
        tipAmount = 0.0
        totalAmount = 0.0
        amountPerPerson = 0.0
    }
    
    func updateTipPercentage(_ percentage: Double) {
        tipPercentage = percentage
        settingsManager.defaultTipPercentage = percentage
    }
    
    func incrementPeople() {
        numberOfPeople += 1
    }
    
    func decrementPeople() {
        numberOfPeople = max(1, numberOfPeople - 1)
    }
    
    func quickTipPercentage(_ percentage: Double) {
        updateTipPercentage(percentage)
    }
}
