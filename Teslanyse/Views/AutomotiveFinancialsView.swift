//
//  AutomotiveFinancialsView.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 28.02.24.
//

import SwiftUI
import Charts

struct AutomotiveFinancialsView: View {
    
    @StateObject var vm: MainViewModel
    @State private var selection = AutomotiveFinancialDataOption.revenue
    @State private var numberFormat: NumberFormatType = .dollar
    
    var body: some View {
        VStack (alignment: .leading) {
            TitleView(title: "Financials")
            SubtitleView(subtitle: "Automotive - \(selection.description)")
            let (xData, yData) = userSelection()
            ChartView(vm: vm, xData: xData, yData: yData, numberFormat: numberFormat)
            Divider()
            InfoButtonSubView(title: "Select metric")
            PickerAutomotiveFinancialsView(selection: $selection)
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
    
    private func userSelection() -> ([Date],[Double]) {
        let xData = vm.extractQuarters()
        let yData: [Double]

        switch (selection) {
        case .revenue:
            yData = vm.extractData(property: .automotiveRevenue)
        case .costOfRevenue:
            yData = vm.extractData(property: .automotiveCostOfRevenue)
        case .profit:
            yData = vm.extractData(property: .automotiveProfit)
        case .margin:
            yData = vm.extractData(property: .automotiveMargin)
        case .cogs:
            yData = vm.extractData(property: .automotiveCostOfGoodsSold)
        }
        return (xData, yData)
    }
    
}

#Preview {
    NavigationStack {
        AutomotiveFinancialsView(vm: vm)
    }
}


struct PickerAutomotiveFinancialsView: View {
    
    @Binding var selection: AutomotiveFinancialDataOption
    
    var body: some View {
        Picker("", selection: $selection) {
            ForEach(AutomotiveFinancialDataOption.allCases, id: \.self) {
                Text($0.description)
            }
        }
        .pickerStyle(.wheel)
    }
}
