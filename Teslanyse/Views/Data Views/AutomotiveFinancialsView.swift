//
//  AutomotiveFinancialsView.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 28.02.24.
//

import SwiftUI

struct AutomotiveFinancialsView: View {
    
    @StateObject var vm: QuarterDataViewModel
    @StateObject private var automotiveFinancialsVM: AutomotiveFinancialsViewModel
    @State private var selection = AutomotiveFinancialDataOption.revenue
    @State private var numberFormat: NumberFormatType = .dollar
    
    init(vm: QuarterDataViewModel) {
        _vm = StateObject(wrappedValue: vm)
        _automotiveFinancialsVM = StateObject(wrappedValue: AutomotiveFinancialsViewModel(mainViewModel: vm))
    }
    
    var body: some View {
        VStack (alignment: .leading) {
            TitleView(title: "Financials")
            SubtitleView(subtitle: "Automotive - \(selection.description)")
            if !vm.quarters.isEmpty {
                let yData = automotiveFinancialsVM.fetchChartData(from: automotiveFinancialsVM.selectedParams.filter { $0.value == true }.map { $0.key }.first!)
                QuarterChartView(vm: vm, yAxislabel: numberFormat.rawValue, yData: yData, numberFormat: numberFormat)
            } else {
                ProgressView()
            }
            Divider()
            InfoButtonView<InfoView<AutomotiveFinancialDataOption>>(title: "Select metric", infoView: InfoView())
            List {
                ForEach(AutomotiveFinancialDataOption.allCases, id: \.self) { param in
                    Label(param.description, systemImage: automotiveFinancialsVM.selectedParams[param] == true ? "checkmark.diamond.fill" : "diamond")
                        .foregroundColor(automotiveFinancialsVM.selectedParams[param] == true ? .green : .primary)
                        .onTapGesture {
                            automotiveFinancialsVM.resetSelection()
                            automotiveFinancialsVM.selectedParams[param, default: false].toggle()
                            numberFormat = automotiveFinancialsVM.selectNumberFormat(for: param)
                        }
                }
            }
            .listStyle(.plain)
            ExportButtonView()
        }
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: selection) {
            numberFormat = automotiveFinancialsVM.selectNumberFormat(for: selection)
        }
    }
}

#Preview {
    NavigationStack {
        AutomotiveFinancialsView(vm: quarterDataVM)
    }
}
