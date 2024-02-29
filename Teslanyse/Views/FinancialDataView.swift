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
                .padding(.horizontal)
            FinancialsPickerView(selection: $selection)
            ExportButtonView()
        }
        .navigationBarTitleDisplayMode(.inline)
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
    var countBarMarks: Int {
        plotDataViewModel.quarters.count
    }
    
    var body: some View {
        let xData = plotDataViewModel.extractQuarters()
        let yData: [Double]

        switch (selection) {
        case .revenue:
            yData = plotDataViewModel.extractData(property: .revenue)
        case .profit:
            yData = plotDataViewModel.extractData(property: .profit)
        case .grossGAAPMargin:
            yData = plotDataViewModel.extractData(property: .margin)
        }
        
        return Chart(0..<countBarMarks, id: \.self) {index in
                BarMark(x: .value("Quarter", xData[index]),
                        y: .value(yAxisLabel, yData[index]))
        }
    }
}


struct FinancialsPickerView: View {
    @Binding var selection: FinancialDataOption
    var body: some View {
        Picker("", selection: $selection) {
            ForEach(FinancialDataOption.allCases, id: \.self) {
                Text($0.description)
            }
        }
        .pickerStyle(.wheel)
    }
}
