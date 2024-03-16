//
//  FinancialDataView.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 27.02.24.
//

import SwiftUI

struct FinancialDataView: View {
    
    @StateObject private var vm: QuarterDataViewModel
    @StateObject private var financialDataVm: FinancialDataViewModel
    @State private var selection: FinancialDataOption = .revenue
    @State private var numberFormat: NumberFormatType = .dollar
    
    init(vm: QuarterDataViewModel) {
        _vm = StateObject(wrappedValue: vm)
        _financialDataVm = StateObject(wrappedValue: FinancialDataViewModel(mainViewModel: vm))
    }
    var body: some View {
        VStack (alignment: .leading) {
            TitleView(title: "Financials")
            SubtitleView(subtitle: "Summary")
            if !vm.quarters.isEmpty {
                let yData = financialDataVm.fetchChartData(from: selection)
                QuarterChartView(vm: vm, yData: yData, numberFormat: numberFormat)
            } else {
                // placeholder
            }
            Divider()
            InfoButtonView<InfoView<FinancialDataOption>>(title: "Select metric", infoView: InfoView())
            PickerView<FinancialDataOption>(selection: $selection)
                .pickerStyle(.wheel)
            ExportButtonView()
        }
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: selection) {
            numberFormat = financialDataVm.selectNumberFormat(for: selection)
        }
    }
}

#Preview {
    NavigationStack {
        FinancialDataView(vm: quarterDataVM)
    }
}
