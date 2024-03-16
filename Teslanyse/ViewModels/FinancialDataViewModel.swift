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
            yData = vm.quarters.map { Double($0.margin) }
        }
        return yData
    }
    
    func selectNumberFormat(for selection: FinancialDataOption) -> NumberFormatType {
        switch selection {
        case .grossGAAPMargin:
            return .percent
        default:
            return .dollar
        }
    }
}
