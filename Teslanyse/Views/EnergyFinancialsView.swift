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
    @State var selection: EnergyFinancialDataOption = .revenue
    @State var numberFormat: NumberFormatType = .dollar
    
    var body: some View {

        VStack (alignment: .leading) {
            TitleView(title: "Financials")
            SubtitleView(subtitle: "Energy - \(selection.description)")
            let (xData, yData) = userSelection()
            ChartView(vm: vm, xData: xData, yData: yData, numberFormat: numberFormat)
            Divider()
            InfoButtonSubView(title: "Select metric")
            EnergyFinancialsPickerView(selection: $selection)
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
        EnergyFinancialsView(vm: vm)
    }
}

struct EnergyFinancialsPickerView: View {
    @Binding var selection: EnergyFinancialDataOption
    var body: some View {
        Picker("", selection: $selection) {
            ForEach(EnergyFinancialDataOption.allCases, id: \.self) {
                Text($0.description)
            }
        }
        .pickerStyle(.wheel)
    }
}
