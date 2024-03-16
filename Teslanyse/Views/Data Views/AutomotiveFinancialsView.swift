//
//  AutomotiveFinancialsView.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 28.02.24.
//

import SwiftUI

struct AutomotiveFinancialsView: View {
    
    @StateObject var vm: QuarterDataViewModel
    @State private var selection = AutomotiveFinancialDataOption.revenue
    @State private var numberFormat: NumberFormatType = .dollar
    
    var body: some View {
        VStack (alignment: .leading) {
            TitleView(title: "Financials")
            SubtitleView(subtitle: "Automotive - \(selection.description)")
            if !vm.quarters.isEmpty {
                let yData = fetchChartData()
                QuarterChartView(vm: vm, yData: yData, numberFormat: .number)
            } else {
                // placeholder
            }
            Divider()
            InfoButtonView<InfoView<AutomotiveFinancialDataOption>>(title: "Select metric", infoView: InfoView())
            PickerView<AutomotiveFinancialDataOption>(selection: $selection)
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
            yData = vm.quarters.map { Double($0.automotiveRevenue) }
        case .costOfRevenue:
            yData = vm.quarters.map { Double($0.automotiveCostOfRevenue) }
        case .profit:
            yData = vm.quarters.map { Double($0.automotiveProfit) }
        case .margin:
            yData = vm.quarters.map { Double($0.automotiveMargin) }
        case .cogs:
            yData = vm.quarters.map { Double($0.automotiveCostOfGoodsSold) }
        }
        return yData
    }
    
}

#Preview {
    NavigationStack {
        AutomotiveFinancialsView(vm: quarterDataVM)
    }
}
