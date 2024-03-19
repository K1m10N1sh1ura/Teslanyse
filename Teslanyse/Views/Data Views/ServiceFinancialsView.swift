//
//  ServiceFinancialsView.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 19.03.24.
//

import SwiftUI

struct ServiceFinancialsView: View {
    
    @StateObject var vm: QuarterDataViewModel
    @State private var selection = ServiceFinancialsOption.revenue
    @State private var numberFormat: NumberFormatType = .dollar
    
    var body: some View {
        VStack (alignment: .leading) {
            TitleView(title: "Financials")
            SubtitleView(subtitle: "Service - \(selection.description)")
            if !vm.quarters.isEmpty {
                let yData = fetchChartData()
                QuarterChartView(vm: vm, yAxislabel: numberFormat.rawValue, yData: yData, numberFormat: numberFormat)
            } else {
                // placeholder
            }
            Divider()
            InfoButtonView<InfoView<ServiceFinancialsOption>>(title: "Select metric", infoView: InfoView())
            PickerView<ServiceFinancialsOption>(selection: $selection)
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
            yData = vm.quarters.map { Double($0.serviceRevenue) }
        case .profit:
            yData = vm.quarters.map { Double($0.serviceProfit) }
        case .margin:
            yData = vm.quarters.map { Double($0.serviceMargin) }
        }
        return yData
    }
    
}

#Preview {
    NavigationStack {
        ServiceFinancialsView(vm: quarterDataVM)
    }
}
