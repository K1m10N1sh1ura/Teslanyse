//
//  FinancialDataView.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 27.02.24.
//

import SwiftUI
import Charts

struct FinancialDataView: View {
    
    @StateObject private var vm: MainViewModel
    @StateObject private var financialDataVm: FinancialDataViewModel
    @State private var selection: FinancialDataOption = .revenue
    @State private var numberFormat: NumberFormatType = .dollar
    
    init(vm: MainViewModel) {
        _vm = StateObject(wrappedValue: vm)
        _financialDataVm = StateObject(wrappedValue: FinancialDataViewModel(mainViewModel: vm))
    }
    var body: some View {
        VStack (alignment: .leading) {
            TitleView(title: "Financials")
            SubtitleView(subtitle: "Summary")
            let (xData, yData) = financialDataVm.fetchChartData(from: selection)
            ChartView(vm: vm, xData: xData, yData: yData, numberFormat: numberFormat)
            Divider()
            InfoButtonSubViewNew<InfoView<FinancialDataOption>>(title: "Select metric", infoView: InfoView())
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
        FinancialDataView(vm: vmPreview)
    }
}
