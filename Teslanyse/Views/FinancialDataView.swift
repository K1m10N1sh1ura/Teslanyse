//
//  FinancialDataView.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 27.02.24.
//

import SwiftUI
import Charts

struct FinancialDataView: View {
    
    @StateObject var plotDataViewModel: PlotDataViewModel
    @State var selection: FinancialDataOption = .revenue
    var body: some View {
        VStack (alignment: .leading) {
            TitleView(title: "Financials")
            SubtitleView(subtitle: "Summary")
            FinancialsChartView(plotDataViewModel: plotDataViewModel, selection: $selection)
            ExportButtonView()
        }
    }
}

#Preview {
    NavigationStack {
        FinancialDataView(plotDataViewModel: plotDataViewModel)
    }
}

struct FinancialsChartView: View {
    @StateObject var plotDataViewModel: PlotDataViewModel
    @Binding var selection: FinancialDataOption
    let yAxisLabel = "$"
    
    var body: some View {
        Chart(plotDataViewModel.quarters) {quarterData in
            
            switch (selection) {
            case .revenue:
                BarMark(x: .value("Quarter", quarterData.date),
                        y: .value(yAxisLabel, quarterData.revenue))
            case .profit:
                BarMark(x: .value("Quarter", quarterData.date),
                        y: .value(yAxisLabel, quarterData.profit))
            case .grossGAAPMargin:
                BarMark(x: .value("Quarter", quarterData.date),
                        y: .value(yAxisLabel, quarterData.margin))
            }
        }
        Picker("", selection: $selection) {
            ForEach(FinancialDataOption.allCases, id: \.self) {
                Text($0.description)
            }
        }
        .pickerStyle(.wheel)
    }
}

