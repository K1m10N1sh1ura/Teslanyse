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
                let yData = financialDataVm.fetchChartData(from: financialDataVm.selectedParams.filter { $0.value == true }.map { $0.key }.first!)
                QuarterChartView(vm: vm, yAxislabel: numberFormat.rawValue, yData: yData, numberFormat: numberFormat)
            } else {
                HStack {
                    Spacer()
                    ProgressView()
                        .padding()
                    Spacer()
                }            }
            Divider()
            InfoButtonView<InfoView<FinancialDataOption>>(title: "Select metric", infoView: InfoView())
            List {
                ForEach(FinancialDataOption.allCases, id: \.self) { param in
                    Label(param.description, systemImage: financialDataVm.selectedParams[param] == true ? "checkmark.diamond.fill" : "diamond")
                        .foregroundColor(financialDataVm.selectedParams[param] == true ? .green : .primary)
                        .onTapGesture {
                            financialDataVm.resetSelection()
                            financialDataVm.selectedParams[param, default: false].toggle()
                            numberFormat = financialDataVm.selectNumberFormat(for: param)
                        }
                }
            }
            .listStyle(.plain)
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
