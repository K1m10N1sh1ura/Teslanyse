//
//  FinancialDataView.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 27.02.24.
//

import SwiftUI
import Charts

struct FinancialDataView: View {
    
    @StateObject var vm: MainViewModel
    @State private var selection: FinancialDataOption = .revenue
    @State private var numberFormat: NumberFormatType = .dollar

    var body: some View {
        VStack (alignment: .leading) {
            TitleView(title: "Financials")
            SubtitleView(subtitle: "Summary")
            let (xData, yData) = userSelection()
            ChartView(vm: vm, xData: xData, yData: yData, numberFormat: numberFormat)
            Divider()
            InfoButtonSubView(title: "Metric")
            FinancialsPickerView(selection: $selection)
            ExportButtonView()
        }
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: selection) {
            switch selection {
            case .grossGAAPMargin:
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
            yData = vm.extractData(property: .revenue)
        case .profit:
            yData = vm.extractData(property: .profit)
        case .grossGAAPMargin:
            yData = vm.extractData(property: .margin)
        }
        return (xData, yData)
    }
    
}

#Preview {
    NavigationStack {
        FinancialDataView(vm: vm)
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
