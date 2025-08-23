//
//  TipCalculatorWidget.swift
//  SimplyTip
//
//  Created by Maxim Golovlev on 22.08.2025.
//


import SwiftUI
import WidgetKit

struct TipCalculatorWidget: Widget {
    let kind: String = "TipCalculatorWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WidgetView(entry: entry)
        }
        .configurationDisplayName("Quick Tip Calculator")
        .description("Calculate tips quickly from your home screen")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), billAmount: "50.00", tipPercentage: 15)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), billAmount: "50.00", tipPercentage: 15)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        let entry = SimpleEntry(date: Date(), billAmount: "50.00", tipPercentage: 15)
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let billAmount: String
    let tipPercentage: Int
}

struct WidgetView: View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family
    @EnvironmentObject private var settingsManager: SettingsManager
    
    var body: some View {
        ZStack {
            Color.black
            
            VStack(spacing: 8) {
                Text("Tip: \(entry.tipPercentage)%")
                    .font(.headline)
                    .foregroundColor(.green)
                
                if let amount = Double(entry.billAmount) {
                    let tip = amount * Double(entry.tipPercentage) / 100
                    let total = amount + tip
                    
                    Text("Tip: \(formatCurrency(tip))")
                        .font(.subheadline)
                        .foregroundColor(.white)
                    
                    Text("Total: \(formatCurrency(total))")
                        .font(.headline)
                        .foregroundColor(.green)
                        .fontWeight(.bold)
                }
                
                Text("Tap to open")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding()
        }
    }
    
    private func formatCurrency(_ amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = settingsManager.getCurrencySymbol()
        return formatter.string(from: NSNumber(value: amount)) ?? "\(amount)"
    }
}
