//
//  FinancialDataNEWView.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 27.02.24.
//

import SwiftUI
import Charts

struct FinancialDataNEWView: View {
    
    @StateObject var vm: MainViewModel
    @State private var numberFormat: NumberFormatType = .dollar
    @State private var isOn: [FinancialDataOption: Bool] = [
        .revenue: false,
        .profit: false,
        .grossGAAPMargin: false
    ]
        
    var body: some View {
        VStack (alignment: .leading) {
            TitleView(title: "Financials")
            SubtitleView(subtitle: "Summary")
            let (xData, yData) = fetchChartData()
            ForEach(yData, id: \.self) {
                ChartView(vm: vm, xData: xData, yData: $0, numberFormat: numberFormat)
            }
            Divider()
            InfoButtonSubView(title: "Metric")
            ForEach(FinancialDataOption.allCases, id: \.self) { option in
                Toggle(option.description, isOn: Binding(
                    get: { self.isOn[option] ?? false },
                    set: { newValue in
                        self.isOn[option] = newValue
                    }
                ))
            }
            .padding(.horizontal)
            ExportButtonView()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func fetchChartData() -> ([Date],[[Double]]) {
        let xData = vm.extractQuarters()
        var yData = [[Double]]()
        var property: QuarterDataEnum = .revenue

        isOn.forEach { key, value in
            if value {
                switch key {
                case .revenue:
                    property = .revenue
                case .profit:
                    property = .profit
                case .grossGAAPMargin:
                    property = .margin
                }
                yData.append(vm.extractData(property: property))
            }

        }
        return (xData, yData)
    }
    
}

#Preview {
    NavigationStack {
        FinancialDataNEWView(vm: vm)
    }
}

