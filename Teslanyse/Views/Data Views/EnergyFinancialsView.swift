//
//  EnergyFinancialsView.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 28.02.24.
//

import SwiftUI
import Charts

struct EnergyFinancialsView: View {
    
    @StateObject var vm: MainViewModel
    @State private var selection: EnergyFinancialDataOption = .revenue
    @State private var numberFormat: NumberFormatType = .dollar
    
    var body: some View {

        VStack (alignment: .leading) {
            TitleView(title: "Financials")
            SubtitleView(subtitle: "Energy - \(selection.description)")
            let (xData, yData) = fetchChartData()
            ChartView(vm: vm, xData: xData, yData: yData, numberFormat: numberFormat)
            Divider()
            InfoButtonSubViewNew<InfoView<EnergyFinancialDataOption>>(title: "Select metric", infoView: InfoView())
            PickerView<EnergyFinancialDataOption>(selection: $selection)
                .pickerStyle(.wheel)
            ExportButtonView()
        }
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: selection) {
            switch selection {
            case .margin:
                numberFormat = .percent
            default:
                numberFormat = .dollar
            }
        }

    }
    
    private var infoView: any View {
        Text("Test")
    }
    
    private func fetchChartData() -> ([Date],[Double]) {
        let xData = vm.extractQuarters()
        let yData: [Double]
        switch (selection) {
        case .revenue:
            yData = vm.extractData(property: .energyRevenue)
        case .costOfRevenue:
            yData = vm.extractData(property: .energyCostOfRevenue)
        case .profit:
            yData = vm.extractData(property: .energyProfit)
        case .margin:
            yData = vm.extractData(property: .energyMargin)
        case .cogs:
            yData = vm.extractData(property: .energyCostOfGoodsSold)
        }
        return (xData, yData)
    }
}

#Preview {
    NavigationStack {
        EnergyFinancialsView(vm: vmPreview)
    }
}
