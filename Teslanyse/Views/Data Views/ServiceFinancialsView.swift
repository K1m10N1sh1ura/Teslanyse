//
//  ServiceFinancialsView.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 19.03.24.
//

import SwiftUI

struct ServiceFinancialsView: View {
    
    @StateObject var vm: QuarterDataViewModel
    @StateObject private var serviceFinancialsVM: ServiceFinancialsViewModel
    @State private var selection = ServiceFinancialsOption.revenue
    @State private var numberFormat: NumberFormatType = .dollar
    
    init(vm: QuarterDataViewModel) {
        _vm = StateObject(wrappedValue: vm)
        _serviceFinancialsVM = StateObject(wrappedValue: ServiceFinancialsViewModel(mainViewModel: vm))
    }
    
    var body: some View {
        VStack (alignment: .leading) {
            TitleView(title: "Financials")
            SubtitleView(subtitle: "Service - \(selection.description)")
            if !vm.quarters.isEmpty {
                let yData = serviceFinancialsVM.fetchChartData(from: serviceFinancialsVM.selectedParams.filter { $0.value == true }.map { $0.key }.first!)
                QuarterChartView(vm: vm, yAxislabel: numberFormat.rawValue, yData: yData, numberFormat: numberFormat)
            } else {
                HStack {
                    Spacer()
                    ProgressView()
                        .padding()
                    Spacer()
                }
            }
            Divider()
            InfoButtonView<InfoView<ServiceFinancialsOption>>(title: "Select metric", infoView: InfoView())
            List {
                ForEach(ServiceFinancialsOption.allCases, id: \.self) { param in
                    Label(param.description, systemImage: serviceFinancialsVM.selectedParams[param] == true ? "checkmark.diamond.fill" : "diamond")
                        .foregroundColor(serviceFinancialsVM.selectedParams[param] == true ? .green : .primary)
                        .onTapGesture {
                            serviceFinancialsVM.resetSelection()
                            serviceFinancialsVM.selectedParams[param, default: false].toggle()
                            numberFormat = serviceFinancialsVM.selectNumberFormat(for: param)
                        }
                }
            }
            .listStyle(.plain)
            ExportButtonView()
        }
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: selection) {
            numberFormat = serviceFinancialsVM.selectNumberFormat(for: selection)
        }
    }
}

#Preview {
    NavigationStack {
        ServiceFinancialsView(vm: quarterDataVM)
    }
}
