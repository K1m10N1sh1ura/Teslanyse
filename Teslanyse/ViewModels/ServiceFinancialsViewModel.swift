//
//  ServiceFinancialsViewModel.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 23.03.24.
//

import Foundation

class ServiceFinancialsViewModel: ObservableObject {
    let vm: QuarterDataViewModel
    @Published var selectedParams: [ServiceFinancialsOption: Bool] = Dictionary(uniqueKeysWithValues: ServiceFinancialsOption.allCases.map { ($0, false) })

    init(mainViewModel: QuarterDataViewModel) {
        self.vm = mainViewModel
        selectedParams[.revenue, default: false].toggle()
    }
    
    func resetSelection() {
        selectedParams = Dictionary(uniqueKeysWithValues: ServiceFinancialsOption.allCases.map { ($0, false) })
    }
    
    func fetchChartData(from selection: ServiceFinancialsOption) -> [Double] {
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
    
    func selectNumberFormat(for selection: ServiceFinancialsOption) -> NumberFormatType {
        switch selection {
        case .margin:
            return .percent
        default:
            return .dollar
        }
    }
}
