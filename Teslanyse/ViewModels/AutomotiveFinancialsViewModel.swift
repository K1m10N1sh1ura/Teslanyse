//
//  AutomotiveFinancialsViewModel.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 23.03.24.
//

import Foundation

class AutomotiveFinancialsViewModel: ObservableObject {
    let vm: QuarterDataViewModel
    @Published var selectedParams: [AutomotiveFinancialDataOption: Bool] = Dictionary(uniqueKeysWithValues: AutomotiveFinancialDataOption.allCases.map { ($0, false) })

    init(mainViewModel: QuarterDataViewModel) {
        self.vm = mainViewModel
        selectedParams[.revenue, default: false].toggle()
    }
    
    func resetSelection() {
        selectedParams = Dictionary(uniqueKeysWithValues: AutomotiveFinancialDataOption.allCases.map { ($0, false) })
    }
    
    func fetchChartData(from selection: AutomotiveFinancialDataOption) -> [Double] {
        let yData: [Double]

        switch (selection) {
        case .revenue:
            yData = vm.quarters.map { Double($0.automotiveRevenue) }
        case .profit:
            yData = vm.quarters.map { Double($0.automotiveProfit) }
        case .margin:
            yData = vm.quarters.map { Double($0.automotiveMargin) } // conversion in percent
        case .cogs:
            yData = vm.quarters.map { Double($0.automotiveCostOfGoodsSold) }
        case .regulatoryCredits:
            yData = vm.quarters.map { Double($0.automotiveRegulatoryCreditsRevenue) }
        case .leasingRevenue:
            yData = vm.quarters.map { Double($0.automotiveLeasingRevenue) }
        case .leasingProfit:
            yData = vm.quarters.map { Double($0.automotiveLeasingProfit) }
        case .leasingMargin:
            yData = vm.quarters.map { Double($0.automotiveLeasingMargin) }
        }
        return yData
    }
    
    func selectNumberFormat(for selection: AutomotiveFinancialDataOption) -> NumberFormatType {
        switch selection {
        case .margin:
            return .percent
        case .leasingMargin:
            return .percent
        default:
            return .dollar
        }
    }
}
