//
//  FinancialDataViewModel.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 11.03.24.
//

import Foundation

class FinancialDataViewModel: ObservableObject {
    let vm: QuarterDataViewModel

    init(mainViewModel: QuarterDataViewModel) {
        self.vm = mainViewModel
    }
    
    func fetchChartData(from selection: FinancialDataOption) -> [Double] {
        let yData: [Double]

        switch (selection) {
        case .revenue:
            yData = vm.quarters.map { Double($0.revenue) }
        case .profit:
            yData = vm.quarters.map { Double($0.profit) }
        case .grossGAAPMargin:
            yData = vm.quarters.map { Double($0.margin) } // conversion in percent
        case .cash:
            yData = vm.quarters.map { Double($0.cash) }
        case .freeCashFlow:
            yData = vm.quarters.map { Double($0.freeCashFlow) }
        case .operatingMargin:
            yData = vm.quarters.map { Double($0.operatingMargin) } // conversion in percent
        case .researchAndDevelopementExpenses:
            yData = vm.quarters.map { Double($0.researchAndDevelopementExpenses) }
        case .sellingGeneralAndAdministrativeExpenses:
            yData = vm.quarters.map { Double($0.sellingGeneralAndAdministrativeExpenses) }
        }
        return yData
    }
    
    func selectNumberFormat(for selection: FinancialDataOption) -> NumberFormatType {
        switch selection {
        case .grossGAAPMargin:
            return .percent
        case .operatingMargin:
            return .percent
        default:
            return .dollar
        }
    }
}
