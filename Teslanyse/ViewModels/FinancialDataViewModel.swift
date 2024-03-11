//
//  FinancialDataViewModel.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 11.03.24.
//

import Foundation

class FinancialDataViewModel: ObservableObject {
    let vm: MainViewModel

    init(mainViewModel: MainViewModel) {
        self.vm = mainViewModel
    }
    
    func fetchChartData(from selection: FinancialDataOption) -> ([Date],[Double]) {
        let xData = vm.extractQuarters()
        let yData: [Double]

        switch (selection) {
        case .revenue:
            yData = vm.extractData(property: .revenue)
        case .profit:
            yData = vm.extractData(property: .profit)
        case .grossGAAPMargin:
            yData = vm.extractData(property: .margin)
        }
        return (xData, yData)
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
