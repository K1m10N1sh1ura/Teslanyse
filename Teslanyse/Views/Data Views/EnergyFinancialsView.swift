//
//  EnergyFinancialsView.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 28.02.24.
//

import SwiftUI

struct EnergyFinancialsView: View {
    
    @StateObject var vm: QuarterDataViewModel
    @State private var selection: EnergyFinancialDataOption = .revenue
    @State private var numberFormat: NumberFormatType = .dollar
    
    var body: some View {

        VStack (alignment: .leading) {
            TitleView(title: "Financials")
            SubtitleView(subtitle: "Energy - \(selection.description)")
            if !vm.quarters.isEmpty {
                let yData = fetchChartData()
                QuarterChartView(vm: vm, yAxislabel: numberFormat.rawValue, yData: yData, numberFormat: numberFormat)
            } else {
                // placeholder
            }
            Divider()
            InfoButtonView<InfoView<EnergyFinancialDataOption>>(title: "Select metric", infoView: InfoView())
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
    
    private func fetchChartData() -> [Double] {
        let yData: [Double]
        switch (selection) {
        case .revenue:
            yData = vm.quarters.map { Double($0.energyRevenue) }
        case .costOfRevenue:
            yData = vm.quarters.map { Double($0.energyCostOfRevenue) }
        case .profit:
            yData = vm.quarters.map { Double($0.energyProfit) }
        case .margin:
            yData = vm.quarters.map { Double($0.energyMargin) }
        case .cogs:
            yData = vm.quarters.map { Double($0.energyCostOfRevenue) }
        }
        return yData
    }
}

#Preview {
    NavigationStack {
        EnergyFinancialsView(vm: quarterDataVM)
    }
}
