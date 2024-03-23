//
//  EnergyFinancialsView.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 28.02.24.
//

import SwiftUI

struct EnergyFinancialsView: View {
    
    @StateObject var vm: QuarterDataViewModel
    @StateObject private var energyFinancialsVM: EnergyFinancialsViewModel
    @State private var selection: EnergyFinancialDataOption = .revenue
    @State private var numberFormat: NumberFormatType = .dollar
    
    init(vm: QuarterDataViewModel) {
        _vm = StateObject(wrappedValue: vm)
        _energyFinancialsVM = StateObject(wrappedValue: EnergyFinancialsViewModel(mainViewModel: vm))
    }
    
    var body: some View {

        VStack (alignment: .leading) {
            TitleView(title: "Financials")
            SubtitleView(subtitle: "Energy - \(selection.description)")
            if !vm.quarters.isEmpty {
                let yData = energyFinancialsVM.fetchChartData(from: energyFinancialsVM.selectedParams.filter { $0.value == true }.map { $0.key }.first!)
                QuarterChartView(vm: vm, yAxislabel: numberFormat.rawValue, yData: yData, numberFormat: numberFormat)
            } else {
                ProgressView()
            }
            Divider()
            InfoButtonView<InfoView<EnergyFinancialDataOption>>(title: "Select metric", infoView: InfoView())
            List {
                ForEach(EnergyFinancialDataOption.allCases, id: \.self) { param in
                    Label(param.description, systemImage: energyFinancialsVM.selectedParams[param] == true ? "checkmark.diamond.fill" : "diamond")
                        .foregroundColor(energyFinancialsVM.selectedParams[param] == true ? .green : .primary)
                        .onTapGesture {
                            energyFinancialsVM.resetSelection()
                            energyFinancialsVM.selectedParams[param, default: false].toggle()
                            numberFormat = energyFinancialsVM.selectNumberFormat(for: param)
                        }
                }
            }
            .listStyle(.plain)
            ExportButtonView()
        }
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: selection) {
            numberFormat = energyFinancialsVM.selectNumberFormat(for: selection)
        }

    }
}

#Preview {
    NavigationStack {
        EnergyFinancialsView(vm: quarterDataVM)
    }
}
