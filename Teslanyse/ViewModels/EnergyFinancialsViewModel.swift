//
//  EnergyFinancialsViewModel.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 23.03.24.
//

import Foundation

class EnergyFinancialsViewModel: ObservableObject {
    let vm: QuarterDataViewModel
    @Published var selectedParams: [EnergyFinancialDataOption: Bool] = Dictionary(uniqueKeysWithValues: EnergyFinancialDataOption.allCases.map { ($0, false) })

    init(mainViewModel: QuarterDataViewModel) {
        self.vm = mainViewModel
        selectedParams[.revenue, default: false].toggle()
    }
    
    func resetSelection() {
        selectedParams = Dictionary(uniqueKeysWithValues: EnergyFinancialDataOption.allCases.map { ($0, false) })
    }
    
    func fetchChartData(from selection: EnergyFinancialDataOption) -> [Double] {
        let yData: [Double]
        switch (selection) {
        case .revenue:
            yData = vm.quarters.map { Double($0.energyRevenue) }
        case .costOfRevenue:
            yData = vm.quarters.map { Double($0.energyCostOfRevenue) }
        case .profit:
            yData = vm.quarters.map { Double($0.energyProfit) }
        case .margin:
            yData = vm.quarters.map { Double($0.energyMargin) }
        case .cogs:
            yData = vm.quarters.map { Double($0.energyCostOfRevenue) }
        }
        return yData
    }
    
    func selectNumberFormat(for selection: EnergyFinancialDataOption) -> NumberFormatType {
        switch selection {
        case .margin:
            return .percent
        default:
            return .dollar
        }
    }
}
