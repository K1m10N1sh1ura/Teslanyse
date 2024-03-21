//
//  CustomMetricView.swift
//  Teslanyse
//
//  Created by Kimio Nishiura on 19.03.24.
//

import SwiftUI

struct CustomMetricView: View {
    @StateObject var vm: QuarterDataViewModel
    @State var selectionMetricOne: QuarterDataEnum = .profit
    @State var selectionMetricTwo: QuarterDataEnum = .revenue
    @State private var numberFormat: NumberFormatType = .dollar

    var body: some View {
        VStack {
            TitleView(title: "Custom metric")
            SubtitleView(subtitle: selectionMetricOne.description + " / " + selectionMetricTwo.description)
            MetricPickerView(vm: vm, selectionMetricOne: $selectionMetricOne, selectionMetricTwo: $selectionMetricTwo)
            if !vm.quarters.isEmpty {
                let yDataOne = fetchChartData(selectedMetric: selectionMetricOne)
                let yDataTwo = fetchChartData(selectedMetric: selectionMetricTwo)
                let yData = zip(yDataOne, yDataTwo).map { $0 / $1 }

                QuarterChartView(vm: vm, yAxislabel: numberFormat.rawValue, yData: yData, numberFormat: numberFormat)
            } else {
                // placeholder
            }
        }
    }
    private func fetchChartData(selectedMetric: QuarterDataEnum) -> [Double] {
        let yData: [Double]

        switch (selectedMetric) {
            
        case .revenue:
            yData = vm.quarters.map { Double($0.revenue) }
        case .profit:
            yData = vm.quarters.map { Double($0.profit) }
        case .margin:
            yData = vm.quarters.map { Double($0.margin) }
        case .operatingMargin:
            yData = vm.quarters.map { Double($0.revenue) }
        case .cash:
            yData = vm.quarters.map { Double($0.operatingMargin) }
        case .freeCashFlow:
            yData = vm.quarters.map { Double($0.freeCashFlow) }
        case .operatingExpenses:
            yData = vm.quarters.map { Double($0.operatingExpenses) }
        case .researchAndDevelopementExpenses:
            yData = vm.quarters.map { Double($0.researchAndDevelopementExpenses) }
        case .sellingGeneralAndAdministrativeExpenses:
            yData = vm.quarters.map { Double($0.sellingGeneralAndAdministrativeExpenses) }
        case .automotiveRevenue:
            yData = vm.quarters.map { Double($0.automotiveRevenue) }
        case .automotiveCostOfRevenue:
            yData = vm.quarters.map { Double($0.automotiveCostOfRevenue) }
        case .automotiveProfit:
            yData = vm.quarters.map { Double($0.automotiveProfit) }
        case .automotiveMargin:
            yData = vm.quarters.map { Double($0.automotiveMargin) }
        case .automotiveCostOfGoodsSold:
            yData = vm.quarters.map { Double($0.automotiveCostOfGoodsSold) }
        case .automotiveLeasingRevenue:
            yData = vm.quarters.map { Double($0.automotiveLeasingRevenue) }
        case .automotiveLeasingProfit:
            yData = vm.quarters.map { Double($0.automotiveLeasingProfit) }
        case .automotiveLeasingMargin:
            yData = vm.quarters.map { Double($0.automotiveLeasingMargin) }
        case .deliveredCars:
            yData = vm.quarters.map { Double($0.deliveredCars) }
        case .producedCars:
            yData = vm.quarters.map { Double($0.producedCars) }
        case .deliveredModel3Y:
            yData = vm.quarters.map { Double($0.deliveredModel3Y) }
        case .deliveredOtherModels:
            yData = vm.quarters.map { Double($0.deliveredOtherModels) }
        case .producedModel3Y:
            yData = vm.quarters.map { Double($0.producedModel3Y) }
        case .producedOtherModels:
            yData = vm.quarters.map { Double($0.producedOtherModels) }
        case .deliveredCarsAccumulated:
            yData = vm.quarters.map { Double($0.deliveredCarsAccumulated) }
        case .producedCarsAccumulated:
            yData = vm.quarters.map { Double($0.producedCarsAccumulated) }
        case .deliveredModel3YAccumulated:
            yData = vm.quarters.map { Double($0.deliveredModel3YAccumulated) }
        case .deliveredOtherModelsAccumulated:
            yData = vm.quarters.map { Double($0.deliveredOtherModelsAccumulated) }
        case .producedModel3YAccumulated:
            yData = vm.quarters.map { Double($0.producedModel3YAccumulated) }
        case .producedOtherModelsAccumulated:
            yData = vm.quarters.map { Double($0.producedOtherModelsAccumulated) }
        case .energyRevenue:
            yData = vm.quarters.map { Double($0.energyRevenue) }
        case .energyCostOfRevenue:
            yData = vm.quarters.map { Double($0.energyCostOfRevenue) }
        case .energyStorage:
            yData = vm.quarters.map { Double($0.energyStorage) }
        case .energyProfit:
            yData = vm.quarters.map { Double($0.energyProfit) }
        case .energyMargin:
            yData = vm.quarters.map { Double($0.energyMargin) }
        case .energyCostOfGoodsSold:
            yData = vm.quarters.map { Double($0.energyCostOfGoodsSold) }
        case .serviceRevenue:
            yData = vm.quarters.map { Double($0.serviceRevenue) }
        case .serviceProfit:
            yData = vm.quarters.map { Double($0.serviceProfit) }
        case .serviceMargin:
            yData = vm.quarters.map { Double($0.serviceMargin) }
        case .solarDeployed:
            yData = vm.quarters.map { Double($0.solarDeployed) }
        case .superchargerStations:
            yData = vm.quarters.map { Double($0.superchargerStations) }
        case .superchargerConnectors:
            yData = vm.quarters.map { Double($0.superchargerConnectors) }
        case .superchargerStationsAccumulated:
            yData = vm.quarters.map { Double($0.superchargerStationsAccumulated) }
        case .superchargerConnectorsAccumulated:
            yData = vm.quarters.map { Double($0.superchargerConnectorsAccumulated) }
        }
        return yData
    }
}



struct MetricPickerView: View {
    @ObservedObject var vm: QuarterDataViewModel
    @Binding var selectionMetricOne: QuarterDataEnum
    @Binding var selectionMetricTwo: QuarterDataEnum
    var body: some View {
        VStack {
            Picker("", selection: $selectionMetricOne) {
                ForEach(Array(QuarterDataEnum.allCases), id: \.self) {
                    Text($0.description)
                }
            }
            Text("vs")
            Picker("", selection: $selectionMetricTwo) {
                ForEach(Array(QuarterDataEnum.allCases), id: \.self) {
                    Text($0.description)
                }
            }
        }
        .bold()
        .pickerStyle(.inline)
        .frame(height: 250)
        .animation(.easeIn, value: selectionMetricOne)
        .animation(.easeIn, value: selectionMetricTwo)
    }
}

#Preview {
    CustomMetricView(vm: quarterDataVM)
}
