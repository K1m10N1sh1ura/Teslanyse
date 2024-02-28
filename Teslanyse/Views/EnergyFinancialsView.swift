//
//  EnergyFinancialsView.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 28.02.24.
//

import SwiftUI
import Charts

struct EnergyFinancialsView: View {
    
    @StateObject var plotDataViewModel: PlotDataViewModel
    @State var selection: EnergyFinancialDataOption = .revenue
    var subtitle: String {
        "Energy - \(selection.description)"
    }
    let yAxisLabel: String = "$"

    
    var body: some View {
        VStack (alignment: .leading) {
            TitleView(title: "Financials")
            SubtitleView(subtitle: subtitle)
            Chart(plotDataViewModel.quarters) {quarterData in
                
                switch (selection) {
                case .revenue:
                    BarMark(x: .value("Quarter", quarterData.date),
                            y: .value(yAxisLabel, quarterData.energyRevenue))
                case .profit:
                    BarMark(x: .value("Quarter", quarterData.date),
                            y: .value(yAxisLabel, quarterData.energyProfit))
                case .cogs:
                    BarMark(x: .value("Quarter", quarterData.date),
                            y: .value(yAxisLabel, quarterData.energyCostOfGoodsSold))
                case .margin:
                    BarMark(x: .value("Quarter", quarterData.date),
                            y: .value(yAxisLabel, quarterData.energyMargin))
                case .costOfRevenue:
                    BarMark(x: .value("Quarter", quarterData.date),
                            y: .value(yAxisLabel, quarterData.energyCostOfRevenue))
                }
            }
            Picker("", selection: $selection) {
                ForEach(EnergyFinancialDataOption.allCases, id: \.self) {
                    Text($0.description)
                }
            }
            .pickerStyle(.wheel)
            ExportButtonView()


        }
    }
}

#Preview {
    NavigationStack {
        EnergyFinancialsView(plotDataViewModel: plotDataViewModel)
    }
}
